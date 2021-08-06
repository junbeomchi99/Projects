package byow.Core;

import byow.TileEngine.TETile;
import byow.TileEngine.Tileset;

import java.util.ArrayList;
import java.util.Random;

import static byow.Core.Engine.HEIGHT;
import static byow.Core.Engine.WIDTH;

public class Room2 {
    private static final long SEED = 2;
    private static final Random RANDOM = new Random(SEED);
    ArrayList<Point> walls = new ArrayList<>();
    ArrayList<Point> floors = new ArrayList<>();
    ArrayList<Point> roomPoints = new ArrayList<>();
    int roomnumb = 0;
    int x0 = 0;
    int x1 = 1;
    int y0 = 0;
    int y1 = 1;

    private int makeRandomNumber(int lowBoundary, int highBoundary) {
        int x = RANDOM.nextInt(highBoundary - lowBoundary) + lowBoundary;
        return x;
    }

    private void randomPoints(TETile[][] world) {
        x0 = makeRandomNumber(1, WIDTH - 2);
        x1 = makeRandomNumber(1, WIDTH - 2);
        y0 = makeRandomNumber(1, HEIGHT - 2);
        y1 = makeRandomNumber(1, HEIGHT - 2);
        if (x0 > x1) {
            int newx1 = x0;
            int newx0 = x1;
            x1 = newx1;
            x0 = newx0;
        }
        if (y0 > y1) {
            int newy0 = y1;
            int newy1 = y0;
            y1 = newy1;
            y0 = newy0;
        }
        if (x0 == x1 || y0 == y1 || world[x0][y0].equals(Tileset.FLOOR)
                || world[x1][y1].equals(Tileset.FLOOR)) {
            randomPoints(world);
        }
        if (x1 - x0 > WIDTH / 5 || y1 - y0 > HEIGHT / 5
                || x1 - x0 < WIDTH / 20 || y1 - y0 < HEIGHT / 10) {
            randomPoints(world);
        }
    }

    public ArrayList<Point> roomPoints() {
        return roomPoints;
    }

    public void makeRandomRoom(TETile[][] world) {
        while (roomnumb < 12) {
            randomPoints(world);
            for (int x = x0; x < x1; x += 1) {
                for (int y = y0; y < y1; y += 1) {
                    world[x][y] = Tileset.FLOOR;
                    floors.add(new Point(x, y));
                }
            }
            roomnumb += 1;
            int x = makeRandomNumber(x0, x1);
            int y = makeRandomNumber(y0, y1);
            if (roomPoints.contains(new Point(x, y))) {
                x = makeRandomNumber(x0, x1);
                y = makeRandomNumber(y0, y1);
            }
            roomPoints.add(new Point(x, y));
            if (floors.size() == 0) {
                makeRandomRoom(world);
            }
        }
    }

    public void connectRooms(TETile[][] world) {
        while (roomPoints.size() > 0) {
            if (roomPoints.size() == 1) {
                break;
            }
            connectTwo(world);
        }
    }

    public void connectLasttoFirst(TETile[][] world) {
        int size = roomPoints.size();
        while (size > 0) {
            Point p1 = roomPoints.get(0);
            Point p2 = roomPoints.get(size - 1);
            int xOne = p1.getX();
            int yOne = p1.getY();
            int x2 = p2.getX();
            int y2 = p2.getY();
            //go right//
            if (xOne < x2) {
                for (int x = xOne; x <= x2; x++) {
                    world[x][yOne] = Tileset.FLOOR;
                    floors.add(new Point(x, yOne));
                }
                //go up//
                if (yOne < y2) {
                    for (int y = yOne; y <= y2; y++) {
                        world[x2][y] = Tileset.FLOOR;
                        floors.add(new Point(x2, y));
                    }
                }
                //go down//
                if (y2 < yOne) {
                    for (int y = yOne; y >= y2; y--) {
                        world[x2][y] = Tileset.FLOOR;
                        floors.add(new Point(x2, y));
                    }
                }
            }
            // go left//
            if (x2 < xOne) {
                for (int x = xOne; x >= x2; x--) {
                    world[x][y2] = Tileset.FLOOR;
                    floors.add(new Point(x, y2));
                }
                //go up//
                if (yOne < y2) {
                    for (int y = yOne; y <= y2; y++) {
                        world[x2][y] = Tileset.FLOOR;
                        floors.add(new Point(x2, y));
                    }
                }
                //go down//
                if (y2 < yOne) {
                    for (int y = yOne; y >= y2; y--) {
                        world[x2][y] = Tileset.FLOOR;
                        floors.add(new Point(x2, y));
                    }
                }
            }
            size--;
        }
    }

    private void connectTwo(TETile[][] world) {
        Point p1 = roomPoints.get(0);
        Point p2 = roomPoints.get(1);
        int xOne = p1.getX();
        int yOne = p1.getY();
        int x2 = p2.getX();
        int y2 = p2.getY();
        roomPoints.remove(0);
        //go right//
        if (xOne < x2) {
            for (int x = xOne; x <= x2; x++) {
                world[x][yOne] = Tileset.FLOOR;
                floors.add(new Point(x, yOne));
            }
            //go up//
            if (yOne < y2) {
                for (int y = yOne; y <= y2; y++) {
                    world[x2][y] = Tileset.FLOOR;
                    floors.add(new Point(x2, y));
                }
            }
            //go down//
            if (y2 < yOne) {
                for (int y = yOne; y >= y2; y--) {
                    world[x2][y] = Tileset.FLOOR;
                    floors.add(new Point(x2, y));
                }
            }
        }
        // go left//
        if (x2 < xOne) {
            for (int x = xOne; x >= x2; x--) {
                world[x][y2] = Tileset.FLOOR;
                floors.add(new Point(x, y2));
            }
            //go up//
            if (yOne < y2) {
                for (int y = yOne; y <= y2; y++) {
                    world[x2][y] = Tileset.FLOOR;
                    floors.add(new Point(x2, y));
                }
            }
            //go down//
            if (y2 < yOne) {
                for (int y = yOne; y >= y2; y--) {
                    world[x2][y] = Tileset.FLOOR;
                    floors.add(new Point(x2, y));
                }
            }
        }
    }

    public void makeWalls(TETile[][] world) {
        for (Point p : floors) {
            for (int i = -1; i <= 1; i++) {
                for (int j = -1; j <= 1; j++) {
                    if (world[p.getX() + i][p.getY() + j].equals(Tileset.NOTHING)) {
                        world[p.getX() + i][p.getY() + j] = Tileset.WALL;
                    }
                }
            }
        }
    }
}
