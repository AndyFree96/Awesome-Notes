def github(user):
    return f"https://github.com/{user}"


def twitter(nick):
    return f"https://twitter.com/@{nick}"


def pypi(proj):
    return f"https://pypi.org/project/{proj}"


url_list = [*map(github, ["andy", "peter"]), twitter("lucy"),
            *map(pypi, ["scipy", "pandas"])]
print(url_list)
print(map(github, ["andy", "peter"]))
