# 实现流动更新逻辑
function stream!(f::Array{Float64, 4}, config::D3Q19Config)
    # 创建一个新的分布函数数组来存储流动后的结果
    f_streamed = copy(f)

    # 根据速度方向更新分布函数
    for x in 1:config.nx, y in 1:config.ny, z in 1:config.nz
        for i in 1:19
            # 计算流动后的格点位置
            x_dest = mod1(x + config.ex[i], config.nx)
            y_dest = mod1(y + config.ey[i], config.ny)
            z_dest = mod1(z + config.ez[i], config.nz)

            # 更新流动后的分布函数
            f_streamed[x_dest, y_dest, z_dest, i] = f[x, y, z, i]
        end
    end

    # 将流动后的分布函数复制回原数组
    f .= f_streamed
end
