import random

class MapGenerator():
    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.map = [[0 for x in range(width)] for y in range(height)]
        self.generate_map()
    
    def generate_map(self):
        for x in range(self.width):
            if x == 0 or x == self.width - 1:
                for y in range(self.height):
                    self.map[x][y] = 1
            else:
                for y in range(self.height):
                    if y == 0 or y == self.height - 1:
                        self.map[x][y] = 1
                    else:
                        # create random wall only if the cell above or left is a wall
                        if self.map[x - 1][y] == 1 or self.map[x][y - 1] == 1:
                            self.map[x][y] = random.randint(0, 1)

    def print_map(self):
        for y in range(self.height):
            for x in range(self.width):
                print(self.map[y][x], end='')
            print()
    
    def get_map(self):
        return self.map

print("MapGenerator class loaded")
print(*list(MapGenerator(10, 10).get_map()), sep='\n')