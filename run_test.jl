using RCG_DFTK_paper
precompile_methods()
# plt1, plt2, plt3 = test_model(; model_name = "silicon")  #GaAs, TiO2
# display(plt1)
# display(plt2)
# display(plt3)
# print("press enter to exit")
(callbacks_l2rcg, callbacks_h1rcg, callbacks_earcg, callbacks_earg, callbacks_scf, as) =  RCG_DFTK_paper.test_gaps()
