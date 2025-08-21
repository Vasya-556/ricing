#!/usr/bin/env python3
 
def find_color_family(hex_color_code):
    base16_dict = {
        '0': 0,
        '1': 1,
        '2': 2,
        '3': 3,
        '4': 4,
        '5': 5,
        '6': 6,
        '7': 7,
        '8': 8,
        '9': 9,
        'a': 10,
        'b': 11,
        'c': 12,
        'd': 13,
        'e': 14,
        'f': 15,
    }

    colors = {
        "bluegrey": (193, 201, 226),
        "brown": (165, 42, 42),
        "carmine": (150, 0, 24),
        "green": (0, 128, 0),
        "grey": (128, 128, 128),
        "indigo": (75, 0, 130),
        "magenta": (255, 0, 255),
        "orange": (255, 165, 0),
        "teal": (0, 128, 128),
        "yellow": (255, 255, 0),
        "cyan": (0, 183, 235),
        "darkcyan": (0, 139, 139),
        "deeporange": (220, 77, 1),
        "palebrown": (152, 118, 84),
        "paleorange": (255, 179, 71),
        "pink": (255, 192, 203),
        "red": (255, 0, 0),
        "violet": (138, 43, 226),
        # "white": (255, 255, 255),
    }

    hex_color_code = hex_color_code[1:]
    hex_color_code = hex_color_code.lower()

    i = 0
    tmp = []
    while i < len(hex_color_code):
        tmp.append((hex_color_code[i], hex_color_code[i+1])) 
        i+=2
        
    rgb_color_code = []
    for i in range(len(tmp)):
        a,b = tmp[i]
        c,d = base16_dict[a], base16_dict[b]
        rgb_color_code.append(d + (c * 16))

    min_distance = 999999
    current_closest = "bluegrey"
    for i in colors:
        r1 = (rgb_color_code[0])
        g1 = (rgb_color_code[1])
        b1 = (rgb_color_code[2])
        r2 = (colors[i][0])
        g2 = (colors[i][1])
        b2 = (colors[i][2])
        distance = (pow((r1-r2),2) + pow((g1-g2),2) + pow((b1-b2),2))
        if distance < min_distance:
            min_distance = distance
            current_closest = i

    return current_closest

def main(hex_code):
    result = find_color_family(hex_code)
    print(result)

import sys
if __name__ == "__main__":
    try:
        main(sys.argv[1])
    except:
        print("bluegrey")
