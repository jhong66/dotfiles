import random
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("min", type=int, help="range minimum value")
parser.add_argument("max", type=int, help="range maximum value")
parser.add_argument("count", type=int, help="number of random values")

args = parser.parse_args()
print(args)

rand_nums = random.choices(range(args.min, args.max + 1), k=args.count)

with open("rand.txt", "w") as file:
    file.write(str(rand_nums))

print(rand_nums)
