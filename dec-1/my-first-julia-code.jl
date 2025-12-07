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

        counter_of_zeros = counter_of_zeros + abs(div(intermediate_value,100))
        println("intermediate_value: $intermediate_value")

        println("Counter of zeros: $counter_of_zeros")

        intermediate_value = intermediate_value%100
        println("intermediate_value: $intermediate_value")


        if intermediate_value < 0
            counter_of_zeros += 1
            intermediate_value = 100+intermediate_value
        end

        actual_position = intermediate_value

        println("Actual position: $actual_position")
        println("Counter of zeros: $counter_of_zeros")
    end

    println("Final position: $actual_position, final counter_of_zeros: $counter_of_zeros")
end
