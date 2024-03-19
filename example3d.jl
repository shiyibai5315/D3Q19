# 包含主模块文件
include("src/D3Q19Model.jl")
include("src/simulation.jl")
include("src/initialize.jl")
include("src/collide.jl")
include("src/stream.jl")
include("src/boundary_conditions.jl")
include("src/utils.jl")
using .D3Q19Model

using Makie
using CairoMakie

# 确保后端选择正确，如果在支持3D的环境中，可以选择GLMakie
using GLMakie

# 模拟数据的初始化
nx, ny, nz = 50, 50, 50
ρ = rand(nx, ny, nz) # 使用随机数据作为示例

# 创建Figure和Axis
fig = Figure()
ax = Axis3(fig[1, 1], title = "3D Density Distribution", aspect = :data)

# 为了简化，这里我们只绘制初始状态的一个切片
initial_slice = ρ[:, :, 25]
surface_obj = surface!(ax, initial_slice)

# 创建动画
anim = Animation()

# 模拟更新过程，这里仅作为示例
for t in 1:100
    # 模拟数据更新，这里使用随机数据作为简化示例
    ρ = rand(nx, ny, nz)
    slice = ρ[:, :, 25] # 选择一个切片进行更新

    # 更新图形数据
    surface_obj[1][] = slice

    # 向动画添加当前帧
    record(anim, fig, t)
end

# 保存动画为视频
save("density_distribution.mp4", anim)
