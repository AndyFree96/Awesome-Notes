def powTwoGen(max=0):
    n = 0
    while n <= max:
        yield 2 ** n
        n += 1


for i in powTwoGen(6):
    print(i)