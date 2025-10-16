# exercises.py
from __future__ import annotations

from dataclasses import dataclass
from typing import Callable, Generator, Optional, Sequence, Tuple, TypeVar, Union

T = TypeVar("T")

def first_then_apply(
    strings: Sequence[str],
    predicate: Callable[[str], bool],
    function: Callable[[str], T],
) -> Optional[T]:
    for s in strings:
        if predicate(s):
            return function(s)
    return None

def powers_generator(*, base: int, limit: int) -> Generator[int, None, None]:
    value = 1
    while value <= limit:
        yield value
        if base == 1:
            break
        if base == 0:
            next_value = 0
        else:
            next_value = value * base
        if next_value > limit:
            break
        value = next_value

def meaningful_line_count(filename: str, /) -> int:
    count = 0
    with open(filename, "r", encoding="utf-8") as f:
        for line in f:
            lstripped = line.lstrip()
            if lstripped == "" or lstripped == "\n":
                continue
            if lstripped[0] == "#":
                continue
            if lstripped.strip() == "":
                continue
            count += 1
    return count

def say(word: Optional[str] = None) -> Union[str, Callable[[Optional[str]], Union[str, "Callable"]]]:
    if word is None:
        return ""

    words = [word]

    def _next(next_word: Optional[str] = None) -> Union[str, Callable[[Optional[str]], Union[str, "Callable"]]]:
        if next_word is None:
            return " ".join(words)
        words.append(next_word)
        return _next

    return _next

@dataclass(frozen=True)
class Quaternion:
    a: float = 0.0
    b: float = 0.0
    c: float = 0.0
    d: float = 0.0

    @property
    def coefficients(self) -> Tuple[float, float, float, float]:
        return (self.a, self.b, self.c, self.d)
    
    @property
    def conjugate(self) -> "Quaternion":
        return Quaternion(self.a, -self.b, -self.c, -self.d)
    
    def __add__(self, other: "Quaternion") -> "Quaternion":
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d,
        )
    
    def __mul__(self, other: "Quaternion") -> "Quaternion":
        a1, b1, c1, d1 = self.a, self.b, self.c, self.d
        a2, b2, c2, d2 = other.a, other.b, other.c, other.d
        return Quaternion(
            a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
            a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
            a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
            a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2,
        )
    
    def __str__(self) -> str:
        parts = []
        def add_part(coeff: float, suffix: str) -> None:
            if coeff == 0.0:
                return
            sign = "+" if coeff > 0 else "-"
            mag = abs(coeff)
            if suffix == "":
                parts.append(f"{coeff}")
                return
            if mag == 1.0:
                piece = f"{sign}{suffix}"
            else:
                piece = f"{sign}{mag}{suffix}"
            parts.append(piece)
        
        if self.a != 0.0:
            add_part(self.a, "")
        add_part(self.b, "i")
        add_part(self.c, "j")
        add_part(self.d, "k")

        if not parts:
            return "0"
        
        s = "".join(parts)
        
        if s[0] == "+":
            s = s[1:]
        return s