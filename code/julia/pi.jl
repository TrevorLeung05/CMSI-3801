using Distributed
addprocs(parse(Int, ARGS[1]))

@everywhere function approximate_pi(trials::Int)
    hits = 0
    for i in 1:trials
        hits += (rand()^2 + rand()^2 < 1) ? 1 : 0
    end
    return hits
end

function main()
    total_trials = 500_000_000
    trials_per_worker = div(total_trials, nworkers())
    hits = pmap(w -> approximate_pi(trials_per_worker), workers())
    return 4 * sum(hits) / total_trials
end

println("Estimating π with $(nworkers()) workers...")
@time estimate = main()
println("π ≈ $estimate")

# 1 worker:  2.553308 seconds
# 2 workers: 2.028669 seconds
# 3 workers: 1.815728 seconds
# 4 workers: 1.723074 seconds
# 5 workers: 1.627347 seconds
# 6 workers: 1.605432 seconds
# 7 workers: 1.569387 seconds
# 8 workers: 1.543749 seconds
# 9 workers: 1.565782 seconds
# 10 workers: 1.603091 seconds
# 11 workers: 1.614633 seconds
# 12 workers: 1.640052 seconds
# 13 workers: 1.711558 seconds
# 14 workers: 1.883807 seconds
# 15 workers: 1.874885 seconds
# 16 workers: 1.961486 seconds
# 17 workers: 2.016150 seconds
# 18 workers: 2.089831 seconds
# 19 workers: 2.193715 seconds
# 20 workers: 2.400178 seconds