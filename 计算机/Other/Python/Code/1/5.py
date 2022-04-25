
def f1(func):
    def wrapper(*args, **kargs):
        print("Started")
        val = func(*args, **kargs)
        print("Ended")
        return val
    return wrapper


@f1
def f(a, b=9):
    print(a, b)

@f1
def add(a, b):
    return a + b

f("hello")
print(add(4, 5))
