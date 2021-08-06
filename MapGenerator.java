package byow.Core;
import byow.TileEngine.TERenderer;
import byow.TileEngine.TETile;
import byow.TileEngine.Tileset;
import edu.princeton.cs.introcs.StdDraw;

import java.util.ArrayList;
import java.util.Map;
import java.util.Random;

import static byow.Core.Engine.HEIGHT;
import static byow.Core.Engine.WIDTH;

public class MapGenerator {
    ArrayList<Point> walls = new ArrayList<>();
    ArrayList<Point> floors = new ArrayList<>();
    ArrayList<Point> roomPoints = new ArrayList<>();
    ArrayList<Point> avatar = new ArrayList<>();
    Point avatarPoint = new Point(0,0);
    ArrayList<Point> monster = new ArrayList<>();
    Point monsterPoint = new Point(0,0);
    ArrayList<Point> treasure = new ArrayList<>();
    int numTreasures = 0;
    public static long SEED;
    private int roomnumb = 0;
    private int x0 = 0;
    private int x1 = 0;
    private int y0 = 0;
    private int y1 = 0;
    static Random RANDOM;
    public TETile[][] world = new TETile[WIDTH][HEIGHT];

    public static void setSeed(long seed) {
        MapGenerator.SEED = seed;
        MapGenerator.RANDOM = new Random(seed);
    }

    private int makeRandomNumber(int lowBoundary, int highBoundary) {
        int x = RANDOM.nextInt(highBoundary - lowBoundary) + lowBoundary;
        return x;
    }
    private void randomPoints() {
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
            randomPoints();
        }
        if (x1 - x0 > WIDTH / 5 || y1 - y0 > HEIGHT / 5
                || x1 - x0 < WIDTH / 20 || y1 - y0 < HEIGHT / 10) {
            randomPoints();
        }
    }
    public void makeRandomRoom() {
        while (roomnumb < makeRandomNumber(6, 20)) {
            randomPoints();

            for (int x = x0; x < x1; x += 1) {
                for (int y = y0; y < y1; y += 1) {
                    world[x][y] = Tileset.FLOOR;
                    floors.add(new Point(x, y));
                }
            }
            roomnumb += 1;
            int x = makeRandomNumber(x0, x1);
            int y = makeRandomNumber(y0, y1);
            roomPoints.add(new Point(x, y));
            if (floors.size() == 0) {
                makeRandomRoom();
            }
        }
    }
    public void connectLasttoFirst() {
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
    public void connectRooms() {
        while (roomPoints.size() > 0) {
            if (roomPoints.size() == 1) {
                break;
            }
            connectTwo();
        }
    }
    private void connectTwo() {
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

    public void makeWalls() {
        for (Point p: floors) {
            for (int i = -1;  i <= 1; i++) {
                for (int j = -1; j <= 1; j++) {
                    if (world[p.getX() + i][p.getY() + j].equals(Tileset.NOTHING)) {
                        world[p.getX() + i][p.getY() + j] = Tileset.WALL;
                        walls.add(new Point(p.getX() + i, p.getY() + j));
                        floors.remove(new Point(p.getX() + i, p.getY() + j));
                    }
                }
            }
        }
    }
    private void makeAvatar() {
        int ranPos = makeRandomNumber(0, floors.size() - 1);
        Point ranPoint = floors.get(ranPos);
        world[ranPoint.getX()][ranPoint.getY()] = Tileset.AVATAR;
        floors.remove(ranPoint);
        avatar.add(ranPoint);
        avatarPoint = ranPoint;
    }

    public void makeMonster() {
        int ranPos = makeRandomNumber(0, floors.size() - 1);
        Point ranPoint = floors.get(ranPos);
        world[ranPoint.getX()][ranPoint.getY()] = Tileset.MONSTER;
        //floors.remove(ranPoint);
        monster.add(ranPoint);
        monsterPoint = ranPoint;
    }
    public void hideTreasures() {
        int ranPos = makeRandomNumber(0, walls.size() - 1);
        Point ranPoint = walls.get(ranPos);
        walls.remove(ranPos);
        world[ranPoint.getX()][ranPoint.getY()] = Tileset.LOCKED_DOOR;
        //floors.remove(ranPoint);
        treasure.add(ranPoint);
        numTreasures ++;
    }

    private void move() {
        //while Point != wall or Point within world and floors//
        char key = StdDraw.nextKeyTyped();
        if (key == 'W' || key == 'w') {
            world[avatarPoint.getX()][avatarPoint.getY() + 1] = Tileset.AVATAR;
            world[avatarPoint.getX()][avatarPoint.getY()] = Tileset.FLOOR;
            avatarPoint = new Point(avatarPoint.getX(), avatarPoint.getY() +1);
        }
        if (key == 'S' || key == 's') {
            world[avatarPoint.getX()][avatarPoint.getY() - 1] = Tileset.AVATAR;
            world[avatarPoint.getX()][avatarPoint.getY()] = Tileset.FLOOR;
            avatarPoint = new Point(avatarPoint.getX(), avatarPoint.getY() - 1);
        }

        if (key == 'A' || key == 'a') {
            world[avatarPoint.getX() - 1][avatarPoint.getY()] = Tileset.AVATAR;
            world[avatarPoint.getX()][avatarPoint.getY()] = Tileset.FLOOR;
            avatarPoint = new Point(avatarPoint.getX() - 1, avatarPoint.getY());
        }
        if (key == 'D' || key == 'd') {
            world[avatarPoint.getX()][avatarPoint.getY() + 1] = Tileset.AVATAR;
            world[avatarPoint.getX()][avatarPoint.getY()] = Tileset.FLOOR;
            avatarPoint = new Point(avatarPoint.getX() + 1, avatarPoint.getY());
        }

    }

    private void monsterMove() {
        Random random = new Random();


    }
    public TETile[][] getWorld() {
        return world;
    }

    public MapGenerator(long seed) {
        RANDOM = new Random(seed);
        for (int x = 0; x < WIDTH; x += 1) {
            for (int y = 0; y < HEIGHT; y += 1) {
                world[x][y] = Tileset.NOTHING;
            }
        }
        //TERenderer Mapren = new TERenderer();
        //Mapren.initialize(WIDTH, HEIGHT);
    }

    public void worldGenerator() {
        makeRandomRoom();
        connectLasttoFirst();
        connectRooms();
        makeWalls();
        makeAvatar();
        makeMonster();
        makeMonster();
        hideTreasures();
        //comment
        //TERenderer Mapren = new TERenderer();
        //Mapren.renderFrame(world);
    }

    /** public static void main(String[] args){
     // initialize the tile rendering engine with a window of size WIDTH x HEIGHT
     TERenderer MapRen = new TERenderer();
     MapRen.initialize(WIDTH, HEIGHT, 1, 1);

     // initialize tiles
     TETile[][] world = new TETile[WIDTH][HEIGHT];

     for (int x = 0; x < WIDTH; x += 1) {
     for (int y = 0; y < HEIGHT; y += 1) {
     world[x][y] = Tileset.NOTHING;
     }
     }
     room2.makeRandomRoom(world);
     room2.connectLasttoFirst(world);
     room2.connectRooms(world);
     room2.makeWalls(world);
     MapRen.renderFrame(world);

     }
     */
}