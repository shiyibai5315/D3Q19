module D3Q19Model

# 导入必要的包
using LinearAlgebra

# 导出接口
export D3Q19Config, initialize, collide!, stream!, apply_boundary_conditions, simulate, save_results

include("config.jl")
include("initialize.jl")
include("collide.jl")
include("stream.jl")
include("boundary_conditions.jl")
include("simulation.jl")
include("utils.jl")

end
