using PseudoPotentialData

function test_gaps_silicon()
    a0 = 10.26

    as = a0:a0/10:2.05*a0
    callbacks_l2rcg = []
    callbacks_h1rcg = []
    callbacks_earcg = []
    callbacks_earg = []
    callbacks_scf = []

    for a = as
        model, basis = silicon_setup(; Ecut = 30, kgrid = [4, 4, 4], supercell_size = [1, 1, 1], a);


        # Convergence we desire in the residual
        tol = 1.0e-8;

        #Initial value
        scfres_start = self_consistent_field(basis; tol = 0.5e-1, nbandsalg = DFTK.FixedBands(model));
        ψ1 = DFTK.select_occupied_orbitals(basis, scfres_start.ψ, scfres_start.occupation).ψ;
        ρ1 = scfres_start.ρ;

        defaultCallback = RcgDefaultCallback();

        # L2RCG
        println("L2RCG")
        callback_l2rcg = ResidualEvalCallback(; defaultCallback, method = EvalRCG())

        DFTK.reset_timer!(DFTK.timer)
        scfres_rcg1 = l2_riemannian_conjugate_gradient(
            basis;
            ψ = ψ1, ρ = ρ1,
            tol, maxiter = 100,
            callback = callback_l2rcg
        );
        println(DFTK.timer)
        callbacks_l2rcg = [callbacks_l2rcg..., callback_l2rcg]

        # H1RCG
        println("H1RCG")
        callback_h1rcg = ResidualEvalCallback(; defaultCallback, method = EvalRCG())

        DFTK.reset_timer!(DFTK.timer)
        scfres_rcg2 = h1_riemannian_conjugate_gradient(
            basis;
            ψ = ψ1, ρ = ρ1,
            tol, maxiter = 100,
            callback = callback_h1rcg
        );
        println(DFTK.timer)
        callbacks_h1rcg = [callbacks_h1rcg..., callback_h1rcg]

        # EARCG
        println("EARCG")
        callback_earcg = ResidualEvalCallback(; defaultCallback, method = EvalRCG())

        DFTK.reset_timer!(DFTK.timer)
        scfres_rcg3 = energy_adaptive_riemannian_conjugate_gradient(
            basis;
            ψ = ψ1, ρ = ρ1,
            tol, maxiter = 100,
            callback = callback_earcg
        );
        println(DFTK.timer)
        callbacks_earcg = [callbacks_earcg..., callback_earcg]

        # EARG
        println("EARG")
        callback_earg = ResidualEvalCallback(; defaultCallback, method = EvalRCG())

        DFTK.reset_timer!(DFTK.timer)
        scfres_rcg4 = energy_adaptive_riemannian_gradient(
            basis;
            ψ = ψ1, ρ = ρ1,
            tol, maxiter = 100,
            callback = callback_earg
        );
        println(DFTK.timer)
        callbacks_earg = [callbacks_earg..., callback_earcg]

        # SCF
        println("SCF")
        callback_scf = ResidualEvalCallback(; defaultCallback, method = EvalSCF())
        is_converged = ResidualEvalConverged(tol, callback_scf)

        DFTK.reset_timer!(DFTK.timer)
        scfres_scf = self_consistent_field(
            basis; tol,
            callback = callback_scf,
            is_converged = is_converged,
            ψ = ψ1, ρ = ρ1,
            maxiter = 100
        );
        println(DFTK.timer)
        callbacks_scf = [callbacks_scf..., callback_scf]
    end
    return (callbacks_l2rcg, callbacks_h1rcg, callbacks_earcg, callbacks_earg, callbacks_scf, as)
end