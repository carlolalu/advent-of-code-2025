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


# Given a number abcwxyz, crafts a mirror number abcwabcw (which might not be after that)
function get_first_mirror_number(lower_bound::Int64)#::Int64
    println("lower_bound: $lower_bound")

    # Operate with the length of the lower bound in decimal notation
    len10 = Int64(Math.floor(Math.log10(lower_bound) + 1));
    len10_of_part_to_discard = div(len10,2);

    println("len10: $len10, len10_of_part_to_discard: $len10_of_part_to_discard")

    first_half_of_lower_bound = div(lower_bound, 10^len10_of_part_to_discard);

    println("first_half_of_lower_bound: $first_half_of_lower_bound")


    if len10 % len10_of_part_to_discard == 0
        second_half_of_lower_bound = lower_bound - first_half_of_mirror_number * 10^len10_of_part_to_discard;

        println("second_half_of_lower_bound: $second_half_of_lower_bound")

        len10_2nd_half = Int64(Math.floor(Math.log10(second_half_of_lower_bound) + 1));
        mirror_number = second_half_of_lower_bound * (10^len10_2nd_half + 1);

        return mirror_number
    else
        len10_1st_half = Int64(Math.floor(Math.log10(first_half_of_lower_bound) + 1));
        mirror_number = first_half_of_mirror_number * (10^len10_1st_half + 1);

        return mirror_number
    end
end

println(get_first_mirror_number(1))
println(get_first_mirror_number(13))
println(get_first_mirror_number(17))
println(get_first_mirror_number(11))
println(get_first_mirror_number(451))
println(get_first_mirror_number(1233))
println(get_first_mirror_number(2233))
println(get_first_mirror_number(4390))
println(get_first_mirror_number(90431))
println(get_first_mirror_number(43190))

# Given a number which in decimal notation is xyz, crafts the number that in decimal notation looks like xyzxyz
