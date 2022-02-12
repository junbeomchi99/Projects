/** package byow.Core;
import byow.TileEngine.TETile;
import byow.TileEngine.Tileset;
import java.util.ArrayList;
import java.util.Random;

import static byow.Core.Engine.HEIGHT;
import static byow.Core.Engine.WIDTH;

public class Room {
    private static final long SEED = 50;
    private static final Random RANDOM = new Random();
    ArrayList<Point> walls = new ArrayList<>();
    ArrayList<Point> floors = new ArrayList<>();
    ArrayList<Point> rooms = new ArrayList<>();
    int widthSize = 0;
    int xStart = 0;
    int heightSize = 0;
    int yStart = 0;
    private Point deleted;
    private int makeRandomNumber(int lowBoundary, int highBoundary) {
        int x = RANDOM.nextInt(highBoundary - lowBoundary) + lowBoundary;
        return x;
    }
    private void helpmakeRoom() {
        widthSize = makeRandomNumber(0, WIDTH / 5);
        xStart = makeRandomNumber(1, WIDTH - widthSize - 1);
        heightSize = makeRandomNumber(0, HEIGHT / 5);
        yStart = makeRandomNumber(1, HEIGHT - heightSize - 1);
    }
    private void updateWallsArray(TETile[][] world) {
        walls.clear();
        for (int x = 0; x < WIDTH; x++) {
            for (int y = 0; y < HEIGHT; y ++ ) {
                if (world[x][y].equals(Tileset.WALL)) {
                    walls.add(new Point(x,y));
                }
            }
        }
    }
    public void makeRandomRoom(TETile[][] world) {
        helpmakeRoom();
        for (int x = xStart; x < (xStart + widthSize); x += 1) {
            for (int y = yStart; y < (yStart + heightSize); y += 1) {
                if (floors.contains(new Point(x, y))) {
                    helpmakeRoom();
                }
            }
        }
        for (int x = xStart; x < (xStart+widthSize); x += 1) {
            for (int y = yStart; y < (yStart + heightSize); y += 1) {
                world[x][y] = Tileset.FLOOR;
                if (world[x + 1][y] == Tileset.NOTHING || world[x + 1][y] != Tileset.FLOOR) {
                    world[x + 1][y] = Tileset.WALL;
                }
                if (world[x - 1][y] == Tileset.NOTHING || world[x - 1][y] != Tileset.FLOOR) {
                    world[x - 1][y] = Tileset.WALL;
                }
                if (world[x][y + 1] == Tileset.NOTHING || world[x][y + 1] != Tileset.FLOOR) {
                    world[x][y + 1] = Tileset.WALL;
                }
                if (world[x][y - 1] == Tileset.NOTHING || world[x][y - 1] != Tileset.FLOOR) {
                    world[x][y - 1] = Tileset.WALL;
                }
            }
        }
        //making the edges wall//
        for (int x = xStart; x < (xStart+widthSize); x += 1) {
            for (int y = yStart; y < (yStart + heightSize); y += 1) {
                if (world[x + 1][y] == Tileset.NOTHING
                        || world[x + 1][y] != Tileset.FLOOR) {
                    world[x + 1][y + 1] = Tileset.WALL;
                }
                if (world[x - 1][y] == Tileset.NOTHING
                        || world[x - 1][y] != Tileset.FLOOR) {
                    world[x - 1][y - 1] = Tileset.WALL;
                }
                if (world[x + 1][y - 1] == Tileset.NOTHING
                        || world[x + 1][y - 1] != Tileset.FLOOR) {
                    world[x + 1][y - 1] = Tileset.WALL;
                }
                if (world[x - 1][y + 1] == Tileset.NOTHING
                        || world[x - 1][y + 1] != Tileset.FLOOR) {
                    world[x - 1][y + 1] = Tileset.WALL;
                }
            }
        }
        updateWallsArray(world);
        if (walls.size() == 0) {
            makeRandomRoom(world);
        }
    }

    public ArrayList<Point> getFloors() {
        return floors;
    }
    public ArrayList<Point> getWalls() {
        return walls;

    }

    public Point randomCoord(ArrayList<Point> walls) {
        int randInt = makeRandomNumber(0, walls.size() - 1);
        Point randPoint = walls.get(randInt);
        if (randPoint.getX() == WIDTH - 1 || randPoint.getX() == 0
                || randPoint.getY() == HEIGHT -1 || randPoint.getY() == 0) {
            randomCoord(walls);
        }
        return randPoint;
    }

    private String getDirection(ArrayList<Point> walls, TETile[][] world) {
        Point randomPoint = randomCoord(walls);
        int xPoint = randomPoint.getX();
        int yPoint = randomPoint.getY();
        String direction = new String();

        if (xPoint !=  0 && xPoint != WIDTH - 1 && yPoint != 0 && yPoint != HEIGHT - 1) {
            world[xPoint][yPoint] = Tileset.FLOOR;
            walls.remove(randomPoint);
            deleted = randomPoint;
            if (world[xPoint - 1][yPoint] == Tileset.NOTHING
                    && world[xPoint + 1][yPoint] == Tileset.FLOOR) {
                //left//
                direction = "left";
            }
            if (world[xPoint + 1][yPoint] == Tileset.NOTHING
                    && world[xPoint - 1][yPoint] == Tileset.FLOOR) {
                //right//
                direction = "right";
            }
            if (world[xPoint][yPoint + 1] == Tileset.NOTHING
                    && world[xPoint][yPoint - 1] == Tileset.FLOOR) {
                //up//
                direction = "up";
            }
            if (world[xPoint][yPoint - 1] == Tileset.NOTHING
                    && world[xPoint][yPoint + 1] == Tileset.FLOOR) {
                //down
                direction = "down";
            }
        } else {
            getDirection(walls, world);
        }
        return direction;
    }
    private int getRandomSize(String direction) {
        int randomSize = 0;
        if (direction.equals("left")) {
            randomSize = makeRandomNumber(1, deleted.getX());
        }
        if (direction.equals("right")) {
            randomSize = makeRandomNumber(1, WIDTH - deleted.getX());
        }
        if (direction.equals("up")) {
            randomSize = makeRandomNumber(1, HEIGHT - deleted.getY());
        }
        if (direction.equals("down")) {
            randomSize = makeRandomNumber(1, deleted.getY());
        }
        return randomSize;
    }
    public void makeHallWays(ArrayList<Point> walls, TETile[][] world) {
        String direction = getDirection(walls, world);
        int randomSize = getRandomSize(direction);
        int startX = deleted.getX();
        int startY = deleted.getY();
        if (direction.equals("left")) {
            for (int x = startX; x > startX - randomSize; x --) {
                world[x][startY] = Tileset.FLOOR;
                world[x][startY - 1] = Tileset.WALL;
                world[x][startY + 1] = Tileset.WALL;
            }
            world[startX - randomSize][startY] = Tileset.WALL;
            world[startX - randomSize][startY - 1] = Tileset.WALL;
            world[startX - randomSize][startY + 1] = Tileset.WALL;
        }
        if (direction.equals("right")) {
            for (int x = startX; x < startX + randomSize ; x ++) {
                world[x][startY] = Tileset.FLOOR;
                world[x][startY - 1] = Tileset.WALL;
                world[x][startY + 1] = Tileset.WALL;
            }
            world[startX + randomSize][startY] = Tileset.WALL;
            world[startX + randomSize][startY - 1] = Tileset.WALL;
            world[startX + randomSize][startY + 1] = Tileset.WALL;
        }
        if (direction.equals("up")) {
            for (int y = startY; y < startY + randomSize; y ++) {
                world[startX][y] = Tileset.FLOOR;
                world[startX - 1][y] = Tileset.WALL;
                world[startX + 1][y] = Tileset.WALL;
            }
            world[startX][startY + randomSize] = Tileset.WALL;
            world[startX - 1][startY + randomSize] = Tileset.WALL;
            world[startX + 1][startY + randomSize] = Tileset.WALL;
        }
        if (direction.equals("down")) {
            for (int y = startY; y > startY - randomSize; y --) {
                world[startX][y] = Tileset.FLOOR;
                world[startX - 1][y] = Tileset.WALL;
                world[startX + 1][y] = Tileset.WALL;
            }
            world[startX][startY - randomSize] = Tileset.WALL;
            world[startX - 1][startY - randomSize] = Tileset.WALL;
            world[startX + 1][startY - randomSize] = Tileset.WALL;
        }
        updateWallsArray(world);
    }
}
*/

