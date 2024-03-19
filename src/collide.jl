# 定义碰撞处理函数
function collide!(f::Array{Float64, 4}, ρ::Array{Float64, 3}, u::Array{Float64, 4}, config::D3Q19Config)
    # 通过D3Q19模型的碰撞过程更新分布函数f
    feq = zeros(size(f))
    csq = 1/3 # 声速平方
    for x in 1:config.nx, y in 1:config.ny, z in 1:config.nz
        ρxyz = ρ[x, y, z]
        uxyz = u[x, y, z, :]
        for i in 1:19
            ei = [config.ex[i], config.ey[i], config.ez[i]]
            ui = dot(uxyz, ei)
            # 计算局部平衡分布函数
            feq[x, y, z, i] = config.w[i] * ρxyz * (1 + 3*ui + 4.5*ui^2 - 1.5*dot(uxyz, uxyz))
        end
    end
    # 更新f为向feq的松弛
    τ = config.τ
    f .= (1 - 1/τ) .* f .+ (1/τ) .* feq
end
