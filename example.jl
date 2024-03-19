# 包含主模块文件
include("src/D3Q19Model.jl")
include("src/simulation.jl")
include("src/initialize.jl")
include("src/collide.jl")
include("src/stream.jl")
include("src/boundary_conditions.jl")
include("src/utils.jl")
using .D3Q19Model

# 导入用于可视化的包
using Makie
using CairoMakie

# 初始化模型配置
config = init_config(50, 50, 50, ρ0=1.0, u0=[0.01, 0.0, 0.0], τ=0.6)

# 执行模拟
ρ, u, f = simulate(config, 100) # 使用较少的步数以快速得到结果

# 保存结果到CSV文件
save_results_to_csv(ρ, "density_distribution.csv")

# 简单的可视化示例：绘制z=25平面的密度分布热图
let z_slice = 25
    density_slice = ρ[:, :, z_slice]
    fig = Figure()
    ax = Axis(fig[1, 1], title="Density Distribution at z=$z_slice")
    heatmap_obj = heatmap!(ax, density_slice)
    Colorbar(fig[1, 2], heatmap_obj, label="Density")
    fig
end
