using Base;

function get_forward_steps(line::AbstractString)::UInt64
    first_char = line[1]

    steps = line[2:end]
    steps = parse(UInt64, steps)

    if first_char == 'L'
        forward_steps = 100 - steps%100
        return forward_steps
    elseif first_char == 'R'
        return steps
    else
        throw(DomainError(first_char, "The first command must be either `L` or `R`"))
    end
end;

input_file = Base.open("input.txt");


let actual_position = 50, counter_of_zeros = 0
    for line in eachline(input_file)
        println(line)

        forward_steps = get_forward_steps(line)
        actual_position = (actual_position + forward_steps)%100

        println("The actual position is: $actual_position")

        if actual_position == 0
            counter_of_zeros += 1
            println("The counter of zeros increased to the number $counter_of_zeros")
        end
    end
    println("The final position is $actual_position and the total number of zeros is $counter_of_zeros")
end 


