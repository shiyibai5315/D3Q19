# 导入所需的模块
using CSV, DataFrames

# 保存模拟结果到CSV文件
function save_results_to_csv(ρ::Array{Float64, 3}, filename::String)
    # 将密度数组转换为DataFrame
    df = DataFrame()
    df.x = Int[]
    df.y = Int[]
    df.z = Int[]
    df.ρ = Float64[]

    nx, ny, nz = size(ρ)
    for x in 1:nx, y in 1:ny, z in 1:nz
        push!(df, (x=x, y=y, z=z, ρ=ρ[x, y, z]))
    end
    
    # 保存DataFrame到CSV
    CSV.write(filename, df)
end

# 示例：加载和分析结果数据
function load_and_analyze_results(filename::String)
    # 加载CSV文件
    df = CSV.read(filename, DataFrame)
    
    # 分析数据，例如计算平均密度
    avg_ρ = mean(df.ρ)
    println("Average density: $avg_ρ")
end
