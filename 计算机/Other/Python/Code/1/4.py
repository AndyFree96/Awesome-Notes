
def f1(func):
    def wrapper(*args, **kargs):
        print("Started")
        func(*args, **kargs)
        print("Ended")
    return wrapper


@f1
def f(a, b=9):
    print(a, b)

f("hello")
