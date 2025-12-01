The Riemannian conjugate gradient method is a method to calculate ground states of the Kohn-Sham minimization problem, implemented using [DFTK.jl](https://github.com/JuliaMolSim/DFTK.jl). 
This is the implementation from this [preprint](https://arxiv.org/abs/2503.16225).

*THIS PACKAGE IS A COPY OF THE [DFTK_RCG](https://github.com/jonas-pueschel/DFTK_RCG) REPOSITORY, WITH SOME ADDINITIONAL EXPERIMENTS FOR THE [PAPER](https://arxiv.org/abs/2503.16225). 
IT IS NOT MAINTAINED. FOR THE 
CURRENT VERSION, SEE [HERE](https://github.com/jonas-pueschel/DFTK_RCG).*


# Usage
This package is not intended to be used other than to re-do the experimentst from [the paper](https://arxiv.org/abs/2503.16225). For package usage, refer to the [DFTK_RCG repository](https://github.com/jonas-pueschel/DFTK_RCG), which is kept up to date. This package can however be used similarly in principal.

## Set up Julia enviroment


 
```julia
using Pkg; Pkg.add(path = "https://github.com/jonas-pueschel/RCG_DFTK_paper.git")
```
