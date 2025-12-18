using Base;
using Base.Math;

input_file = Base.open("input.txt");
input_string = read(input_file, String);
close(input_file);

# Extract the intervals
raw_intervals = split(input_string, ',');

function get_interval_tuple(raw_interval::AbstractString)::Tuple{Int64,Int64}
    raw_interval = split(raw_interval, '-');
    return (parse(Int64, raw_interval[1]),parse(Int64, raw_interval[2]));
end

intervals = [get_interval_tuple(raw_interval) for raw_interval in raw_intervals];

# We ignore the possibility of having overflow here
function get_mirror_num(number::Int64)::Int64
    len10 = Int64(Math.floor(Math.log10(number) + 1));
    return number * (10^len10 + 1)
end


# Given a number abcwxyz, crafts a mirror number abcwabcw (which might not be after that)
function get_first_base_for_mirror_number(lower_bound::Int64)#::Int64
    println("lower_bound: $lower_bound")

    # Operate with the length of the lower bound in decimal notation
    len10 = Int64(Math.floor(Math.log10(lower_bound) + 1));
    len10_of_part_to_discard = div(len10,2);

    first_half_of_lower_bound = div(lower_bound, 10^len10_of_part_to_discard);
    second_half_of_lower_bound = lower_bound - first_half_of_lower_bound * 10^len10_of_part_to_discard;

    return max(first_half_of_lower_bound, second_half_of_lower_bound)
end

# Given a number which in decimal notation is xyz, crafts the number that in decimal notation looks like xyzxyz

let sum_of_dumb_ids = 0
    for interval in intervals
        println("Searching in interval $interval")

        lower_bound = interval[1]
        upper_bound = interval[2]

        let base_of_mirror_number = get_first_base_for_mirror_number(lower_bound), mirror_num = get_mirror_num(base_of_mirror_number)
            while mirror_num <= upper_bound
                sum_of_dumb_ids += mirror_num
                println("New mirror number found in the interval: $mirror_num. The sum is now $sum_of_dumb_ids")
                mirror_num += get_mirror_num(base_of_mirror_number + 1)
            end
        end
    end
    println(sum_of_dumb_ids)
end