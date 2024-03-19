using D3Q19Model
using Documenter

DocMeta.setdocmeta!(D3Q19Model, :DocTestSetup, :(using D3Q19Model); recursive=true)

makedocs(;
    modules=[D3Q19Model],
    authors="shiyibai5315",
    sitename="D3Q19Model.jl",
    format=Documenter.HTML(;
        canonical="https://shiyibai5315.github.io/D3Q19Model.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/shiyibai5315/D3Q19Model.jl",
    devbranch="main",
)
