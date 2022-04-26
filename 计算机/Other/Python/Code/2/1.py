from numpy import number


class PowTwo:
    """
    Class to implement an iterator of power of
    two
    """

    def __init__(self, max) -> None:
        self.max = max

    def __iter__(self):
        self.n = 0
        return self

    def __next__(self):
        if self.n <= self.max:
            result = 2 ** self.n
            self.n += 1
            return result
        else:
            raise StopIteration


# create an object
numbers = PowTwo(3)

# create an iterable from the object
i = iter(numbers)

# Using next to get the next iterator element
print(next(i))
print(next(i))
print(next(i))
print(next(i))

for i in PowTwo(5):
    print(i)


