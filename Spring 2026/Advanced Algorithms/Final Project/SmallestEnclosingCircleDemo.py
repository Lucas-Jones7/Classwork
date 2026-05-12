import math
import random
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from typing import Optional

class Point:
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def __repr__(self):
        return f"({self.x}, {self.y})"


class Circle:
    def __init__(self, cx: float, cy: float, r: float):
        self.cx = cx
        self.cy = cy
        self.r  = r

    def __repr__(self):
        return f"Circle(center=({self.cx:.4f}, {self.cy:.4f}), r={self.r:.4f})"

    def contains(self, p: Point, eps: float = 1e-7) -> bool:
        dx = p.x - self.cx
        dy = p.y - self.cy
        return (dx * dx + dy * dy) <= (self.r * self.r) + eps

    def on_boundary(self, p: Point, eps: float = 1e-7) -> bool:
        dx = p.x - self.cx
        dy = p.y - self.cy
        dist_sq = dx * dx + dy * dy
        r_sq    = self.r * self.r
        return abs(dist_sq - r_sq) <= eps * max(1.0, r_sq)


# ---------------------------------------------------------------------------
# Base-case solvers
# ---------------------------------------------------------------------------

def circle_from_one(p: Point) -> Circle:
    return Circle(p.x, p.y, 0.0)


def circle_from_two(p1: Point, p2: Point) -> Circle:
    cx = (p1.x + p2.x) / 2
    cy = (p1.y + p2.y) / 2
    r  = math.hypot(p1.x - p2.x, p1.y - p2.y) / 2
    return Circle(cx, cy, r)


def circle_from_three(p1: Point, p2: Point, p3: Point) -> Optional[Circle]:
    ax, ay = p1.x, p1.y
    bx, by = p2.x, p2.y
    cx, cy = p3.x, p3.y
    D = 2 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
    if abs(D) < 1e-10:
        return None
    ux = ((ax**2 + ay**2) * (by - cy) +
          (bx**2 + by**2) * (cy - ay) +
          (cx**2 + cy**2) * (ay - by)) / D
    uy = ((ax**2 + ay**2) * (cx - bx) +
          (bx**2 + by**2) * (ax - cx) +
          (cx**2 + cy**2) * (bx - ax)) / D
    return Circle(ux, uy, math.hypot(ax - ux, ay - uy))


def trivial_circle(R: list) -> Optional[Circle]:
    if len(R) == 0: return None
    if len(R) == 1: return circle_from_one(R[0])
    if len(R) == 2: return circle_from_two(R[0], R[1])
    c = circle_from_three(R[0], R[1], R[2])
    if c is None:
        pairs = [(R[0], R[1]), (R[1], R[2]), (R[0], R[2])]
        return max((circle_from_two(a, b) for a, b in pairs), key=lambda c: c.r)
    return c


# ---------------------------------------------------------------------------
# Welzl's algorithm
# ---------------------------------------------------------------------------

def _b_minidisk(pts: list, R: list) -> Optional[Circle]:
    D = trivial_circle(R)
    for i, p in enumerate(pts):
        if D is not None and D.contains(p):
            continue
        new_R = R + [p]
        if len(new_R) == 3:
            D = trivial_circle(new_R)
        else:
            D = _b_minidisk(pts[:i], new_R)
    return D


def minidisk(points: list) -> Optional[Circle]:
    if not points:
        return None
    pts = points[:]
    random.shuffle(pts)
    return _b_minidisk(pts, [])


# ---------------------------------------------------------------------------
# Find boundary points
# ---------------------------------------------------------------------------

def find_boundary_points(points: list, circle: Circle) -> list:
    return [p for p in points if circle.on_boundary(p)]


# ---------------------------------------------------------------------------
# Input parsing
# ---------------------------------------------------------------------------

def parse_points(raw: str) -> list:
    import re
    numbers = re.findall(r'-?\d+(?:\.\d+)?', raw)
    if len(numbers) < 2:
        raise ValueError("Need at least 2 numbers to form a point.")
    if len(numbers) % 2 != 0:
        raise ValueError(f"Got {len(numbers)} numbers — need an even count (x,y pairs).")
    return [Point(float(numbers[i]), float(numbers[i+1]))
            for i in range(0, len(numbers), 2)]


# ---------------------------------------------------------------------------
# Plot
# ---------------------------------------------------------------------------

def plot(points: list, circle: Circle, boundary: list):
    fig, ax = plt.subplots(figsize=(7, 7))
    ax.set_aspect('equal')
    ax.set_facecolor('#f8f8f8')
    fig.patch.set_facecolor('#ffffff')

    # Enclosing circle
    circ_patch = patches.Circle(
        (circle.cx, circle.cy), circle.r,
        fill=False, edgecolor='#2a6ebb', linewidth=2.0, linestyle='--', zorder=2
    )
    ax.add_patch(circ_patch)

    # Center marker
    ax.plot(circle.cx, circle.cy, '+', color='#2a6ebb', markersize=12,
            markeredgewidth=2, zorder=3, label='Center')

    # Interior vs boundary points
    interior = [p for p in points if p not in boundary]

    if interior:
        ax.scatter([p.x for p in interior], [p.y for p in interior],
                   color='#444444', s=60, zorder=4, label='Interior points')

    if boundary:
        ax.scatter([p.x for p in boundary], [p.y for p in boundary],
                   color='#cc3333', s=90, zorder=5, label='Boundary points',
                   edgecolors='#881111', linewidths=1.2)

    # Labels
    for p in points:
        ax.annotate(f"({p.x:g}, {p.y:g})",
                    xy=(p.x, p.y),
                    xytext=(6, 6), textcoords='offset points',
                    fontsize=9, color='#333333')

    pad = circle.r * 0.25 + 0.5
    ax.set_xlim(circle.cx - circle.r - pad, circle.cx + circle.r + pad)
    ax.set_ylim(circle.cy - circle.r - pad, circle.cy + circle.r + pad)

    ax.grid(True, linestyle=':', color='#cccccc', linewidth=0.8)
    ax.legend(loc='upper right', fontsize=9)
    ax.set_title(
        f"Minimum Enclosing Circle\n"
        f"center = ({circle.cx:.3f}, {circle.cy:.3f}),  "
        f"radius = {circle.r:.3f}",
        fontsize=11
    )

    plt.tight_layout()
    plt.show()


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print("=" * 54)
    print("  Welzl's Minimum Enclosing Circle — Activity")
    print("=" * 54)
    print()

    while True:
        raw = input("Enter point set: ").strip()
        if not raw:
            print("  No input given, please try again.\n")
            continue
        try:
            points = parse_points(raw)
        except ValueError as e:
            print(f"  Error: {e}\n")
            continue
        if len(points) < 2:
            print("  Please enter at least 2 points.\n")
            continue
        break

    random.seed()
    circle = minidisk(points)

    print()
    print(f"  Minimum enclosing circle:")
    print(f"    {circle}")

    boundary = find_boundary_points(points, circle)

    print()
    if boundary:
        print(f"  Points on the boundary ({len(boundary)}):")
        for p in boundary:
            print(f"    {p}")
    else:
        print("  No points exactly on the boundary (numerical precision).")

    print()
    plot(points, circle, boundary)


if __name__ == "__main__":
    main()