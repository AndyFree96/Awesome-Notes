# Making Getter and Setter methods
class Celsius:
    def __init__(self, temperature = 0) -> None:
        self.set_temperature(temperature)

    def to_fahrenheit(self):
        return (self.get_temperature() * 1.8) + 32

    # getter method
    def get_temperature(self):
        return self._temprature

    # setter method
    def set_temperature(self, value):
        if value < -273.12:
            raise ValueError("Temprature below -273.15 is not possible.")
        self._temprature = value


human = Celsius(37)

print(human.get_temperature())

print(human.to_fahrenheit())

human.set_temprature(-300)

print(human.to_fahrenheit())