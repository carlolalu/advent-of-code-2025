using Base;

function get_steps(instruction::AbstractString)::Int64
    first_char = instruction[1]
    steps = parse(UInt64, instruction[2:end])

    if first_char == 'L'
        return -Int64(steps)
    elseif first_char == 'R'
        return steps
    else
        throw(DomainError(first_char, "The first command must be either `L` or `R`"))
    end
end


input_file = Base.open("input.txt");

let actual_position = 50, counter_of_zeros = 0
    for instruction in eachline(input_file)

        println("Receiveid instruction: $instruction")

        steps = get_steps(instruction)
        intermediate_value = actual_position + steps

        println("Non-processed position after the instruction: $intermediate_value")

        intermediate_value = intermediate_value%100
        if intermediate_value < 0

            println("INTERMEDIATE VALUE IS NEGATIVE: $intermediate_value")

            intermediate_value = 100+intermediate_value
        end

        actual_position = intermediate_value

        println("Actual position: $actual_position")
        
        if actual_position == 0
            counter_of_zeros += 1
            println("We have one more zero, now we are at: $counter_of_zeros")
        end
    end

    println("Final position: $actual_position, final counter_of_zeros: $counter_of_zeros")
end
