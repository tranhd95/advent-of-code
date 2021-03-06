INSTRUCTIONS = split.(readlines("files/8.in"), " ")

function does_terminate(instructions)
    acc = 0
    executed = Set()
    l = 1
    while l ≤ length(instructions)
        if l ∈ executed
            return acc, false
        end
        push!(executed, l)
        ins, arg = instructions[l][1], parse(Int, instructions[l][2])
        if ins == "nop"
            l += 1
        elseif ins == "acc"
            acc += arg
            l += 1
        elseif ins == "jmp"
            l += arg
        end
    end
    return acc, true
end

function part1(instructions)
    does_terminate(instructions)
end

function part2(instructions)
    for (i, (ins, arg)) ∈ enumerate(instructions)
        if ins == "nop"
            instructions[i] = ["jmp", arg]
        elseif ins == "jmp"
            instructions[i] = ["nop", arg]
        end
        acc, isTerminated = does_terminate(instructions)
        if isTerminated
            return acc
        end
        instructions[i] = [ins, arg]
    end
end



part1(INSTRUCTIONS) |> first |> println
part2(INSTRUCTIONS) |> println
