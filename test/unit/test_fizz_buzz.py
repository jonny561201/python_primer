from utilities.fizz_buzz import fizz_buzz


def test_fizz_buzz__should_return_fizz_when_divide_by_three():
    actual = fizz_buzz(3)
    assert actual == 'fizz'


def test_fizz_buzz__should_return_buzz_when_divide_by_five():
    actual = fizz_buzz(5)
    assert actual == 'buzz'


def test_fizz_buzz__should_return_fizz_buzz_when_divide_by_fifteen():
    actual = fizz_buzz(15)
    assert actual == 'fizz_buzz'


def test_fizz_buzz__should_return_nothing_when_divide_by_two():
    num = 2
    actual = fizz_buzz(num)
    assert actual == num
