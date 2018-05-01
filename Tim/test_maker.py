def string_of_int(n):
    str_n = str(n)
    z = 3 - len(str_n)
    return "0" * z + str_n

def make_line1(n):
    num = string_of_int(n)
    return "let test"+num+"_name            = \"Timothy "+num+"\"\n"

def make_line2(n):
    num = string_of_int(n)
    return "let test"+num+"_expression      = 0\n"

def make_line3(n):
    num = string_of_int(n)
    return "let test"+num+"_expected_result = 1\n"

def make_bottom_line(n):
    num = string_of_int(n)
    return "  test"+num+"_name >:: (fun _ -> assert_equal test"+num+"_expected_result test"+num+"_expression);\n"


def make_top():
    file = open("output.txt", "w")
    for i in range(0, 101):
        file.write(make_line1(i))
        file.write(make_line2(i))
        file.write(make_line3(i))
        file.write("\n")

def make_bottom():
    file = open("output.txt", "w")
    for i in range(0, 101):
        file.write(make_bottom_line(i))

make_top()
