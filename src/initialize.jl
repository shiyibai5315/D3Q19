# 导入需要的模块
using LinearAlgebra

# 初始化模型状态
function initialize(config::D3Q19Config)
    # 初始化密度和速度场
    ρ = fill(config.ρ0, config.nx, config.ny, config.nz)
    u = zeros(config.nx, config.ny, config.nz, 3)
    for i in 1:3
        u[:, :, :, i] .= config.u0[i]
    end

    # 初始化分布函数
    f = zeros(config.nx, config.ny, config.nz, 19)
    feq = zeros(config.nx, config.ny, config.nz, 19)
    
    # 计算初始平衡分布函数
    csq = 1/3 # 声速平方
    for x in 1:config.nx, y in 1:config.ny, z in 1:config.nz
        ρxyz = ρ[x, y, z]
        uxyz = u[x, y, z, :]
        for i in 1:19
            ei = [config.ex[i], config.ey[i], config.ez[i]]
            ui = dot(uxyz, ei)
            feq[x, y, z, i] = config.w[i] * ρxyz * (1 + 3*ui + 4.5*ui^2 - 1.5*dot(uxyz, uxyz))
        end
    end
    
    # 初始化f为feq
    f .= feq
    
    return ρ, u, f
end
