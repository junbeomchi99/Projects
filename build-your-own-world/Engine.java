package byow.Core;

import byow.TileEngine.TERenderer;
import byow.TileEngine.TETile;
import byow.TileEngine.Tileset;
import edu.princeton.cs.introcs.StdDraw;

import java.awt.Font;
import java.awt.Color;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.File;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.awt.Color.BLACK;

public class Engine {
    /* Feel free to change the width and height. */
    public static final int WIDTH = 80;
    public static final int HEIGHT = 30;
    private static final int KEYBOARD = 0;
    private static final int RANDOM = 1;
    Point avatarPosition = new Point(0, 0);
    Boolean worldgenerated = false;
    TETile[][] map;
    TERenderer ter = new TERenderer();
    Boolean gameExitted = false;
    int numWorld = 0;
    String saveSequence = "";
    ArrayList<Point> monster = new ArrayList<>();
    Point monsterPoint = new Point(0,0);

    /**
     * Method used for exploring a fresh world. This method should handle all inputs,
     * including inputs from the main menu.
     */
    public void interactWithKeyboard() throws IOException {
        drawMainMenu();
        StringBuilder seed = new StringBuilder();
        while (true) {
            while (StdDraw.hasNextKeyTyped()) {
                String c = String.valueOf(StdDraw.nextKeyTyped());
                seed = seed.append(c);
                if (c.equals("n") || c.equals("N")) {
                    StdDraw.clear(Color.PINK);
                    StdDraw.text(0.5, 0.7, "Please enter a seed");
                    StdDraw.text(0.5, 0.08, "press 's' to start!");
                }
                if (worldgenerated) {
                    ter.renderFrame(map);
                    move(map, c);
                }
                if (!worldgenerated) {
                    if (c.equals("s") || c.equals("S")) {
                        String randomSeed = seed.toString();
                        ter.initialize(WIDTH, HEIGHT);
                        map = interactWithInputString(randomSeed);
                        ter.renderFrame(map);
                        userDisplay(map);
                        worldgenerated = true;
                        numWorld++;
                    }
                }

                if (c.equals("q")) {
                    Pattern p = Pattern.compile(":q");
                    Matcher m = p.matcher(seed.toString());
                    if (m.find()) {
                        save(seed);
                        gameExitted = true;
                    }
                }
                if (c.equals("Q")) {
                    Pattern p = Pattern.compile(":Q");
                    Matcher m = p.matcher(seed.toString());
                    if (m.find()) {
                        save(seed);
                        gameExitted = true;
                    }
                }
                if (c.equals("l") || c.equals("L")) {
                    ter.initialize(WIDTH, HEIGHT);
                    load(seed);
                    ter.renderFrame(map);
                    worldgenerated = true;
                } else {
                    StdDraw.clear(BLACK);
                    StdDraw.text(0.5, 0.7, "Please enter a seed");
                    StdDraw.text(0.5, 0.45, "Seed " + seed.toString());
                    StdDraw.text(0.5, 0.08, "press 's' to start!");
                }
            }
        }
    }
    private void move(TETile[][] world, String c) {
        int currentX = avatarPosition.getX();
        int currentY = avatarPosition.getY();
        if (c.equals("W") || c.equals("w")) {
            if (!world[currentX][currentY + 1].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX][currentY + 1] = Tileset.AVATAR;
                avatarPosition = new Point(currentX, currentY + 1);
                ter.renderFrame(world);
                userDisplay(world);
                bomb();
                ter.renderFrame(world);
            }
        }
        if (c.equals("a") || c.equals("A")) {
            if (!world[currentX - 1][currentY].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX - 1][currentY] = Tileset.AVATAR;
                avatarPosition = new Point(currentX - 1, currentY);
                ter.renderFrame(world);
                userDisplay(world);
                bomb();
                ter.renderFrame(world);
            }
        }
        if (c.equals("s") || c.equals("S")) {
            if (!world[currentX][currentY - 1].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX][currentY - 1] = Tileset.AVATAR;
                avatarPosition = new Point(currentX, currentY - 1);
                ter.renderFrame(world);
                userDisplay(world);
                bomb();
                ter.renderFrame(world);
            }
        }
        if (c.equals("d") || c.equals("D")) {
            if (!world[currentX + 1][currentY].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX + 1][currentY] = Tileset.AVATAR;
                avatarPosition = new Point(currentX + 1, currentY);
                ter.renderFrame(world);
                userDisplay(world);
                bomb();
                ter.renderFrame(world);
            }
        }
    }
    private void bomb() {
        StdDraw.clear(BLACK);
        StdDraw.setPenColor(Color.PINK);
        Font title = new Font("Arial", Font.BOLD, 20);
        StdDraw.setFont(title);
        if (monsterPoint.getX() == avatarPosition.getX() + 1 && monsterPoint.getY() == avatarPosition.getY()) {
            System.out.println("Bomb! You Died! GAME OVER");
            StdDraw.setCanvasSize(WIDTH, HEIGHT);
            StdDraw.clear(Color.BLACK);
            StdDraw.text(0.5, 0.5, "Bomb! You Died! GAME OVER");
            StdDraw.show();
            System.exit(0);
        }
        if (monsterPoint.getX() == avatarPosition.getX() - 1 && monsterPoint.getY() == avatarPosition.getY()) {
            System.out.println("Bomb! You Died! GAME OVER");
            StdDraw.setCanvasSize(WIDTH, HEIGHT);
            StdDraw.clear(Color.BLACK);
            StdDraw.text(0.5, 0.5, "Bomb! You Died! GAME OVER");
            System.exit(0);
        }
        if (monsterPoint.getX() == avatarPosition.getX() && monsterPoint.getY() == avatarPosition.getY() + 1) {
            System.out.println("Bomb! You Died! GAME OVER");
            StdDraw.setCanvasSize(WIDTH, HEIGHT);

            StdDraw.clear(Color.BLACK);
            StdDraw.text(0.5, 0.5, "Bomb! You Died! GAME OVER");
            System.exit(0);
        }
        if (monsterPoint.getX() == avatarPosition.getX() && monsterPoint.getY() == avatarPosition.getY() - 1) {
            System.out.println("Bomb! You Died! GAME OVER");
            StdDraw.setCanvasSize(WIDTH, HEIGHT);
            StdDraw.clear(Color.BLACK);
            StdDraw.text(0.5, 0.5, "Bomb! You Died! GAME OVER");
            System.exit(0);

        }
    }
    private void save(StringBuilder input) {
        File f = new File("save.txt");
        try {
            if (!f.exists()) {
                f.createNewFile();
            }
            saveSequence = input.delete(input.length() - 2, input.length()).toString();
            BufferedWriter w = new BufferedWriter(new FileWriter(f));
            w.write(saveSequence);
            w.close();
            System.exit(0);
        } catch (FileNotFoundException e) {
            System.out.println("no such file is found");
            System.exit(0);
        } catch (IOException o) {
            System.out.println(o);
            System.exit(0);
        }
    }
    private void load(StringBuilder input) {
        File f = new File("save.txt");
        if (f.exists()) {
            try {
                FileReader fReader = new FileReader("save.txt");
                BufferedReader bReader = new BufferedReader(fReader);
                String loading = bReader.readLine();
                if (loading.isEmpty()) {
                    System.out.println("the world is empty");
                    System.exit(0);
                } else {
                    interactWithInputString(loading);
                }
            } catch (FileNotFoundException e) {
                System.out.println("no such file found");
                System.exit(0);
            } catch (IOException e) {
                System.out.println(e);
                System.exit(0);
            }
        }
    }
    private void moveAG(TETile[][] world, String c) {
        int currentX = avatarPosition.getX();
        int currentY = avatarPosition.getY();
        if (c.equals("W") || c.equals("w")) {
            if (!world[currentX][currentY + 1].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX][currentY + 1] = Tileset.AVATAR;
                avatarPosition = new Point(currentX, currentY + 1);
                bomb();
            }
        }
        if (c.equals("a") || c.equals("A")) {
            if (!world[currentX - 1][currentY].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX - 1][currentY] = Tileset.AVATAR;
                avatarPosition = new Point(currentX - 1, currentY);
                bomb();

            }
        }
        if (c.equals("s") || c.equals("S")) {
            if (!world[currentX][currentY - 1].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX][currentY - 1] = Tileset.AVATAR;
                avatarPosition = new Point(currentX, currentY - 1);
                bomb();

            }
        }
        if (c.equals("d") || c.equals("D")) {
            if (!world[currentX + 1][currentY].equals(Tileset.WALL)) {
                world[currentX][currentY] = Tileset.FLOOR;
                world[currentX + 1][currentY] = Tileset.AVATAR;
                avatarPosition = new Point(currentX + 1, currentY);
                bomb();
            }
        }
    }
    private void userDisplay(TETile[][] w) {
        while ((int) StdDraw.mouseX() >= 0 && (int) StdDraw.mouseX() <= 79) {
            Font font = new Font("Chalkboard", Font.BOLD, 20);
            StdDraw.setFont(font);
            StdDraw.setPenColor(Color.pink);
            int mousePointerX = (int) StdDraw.mouseX();
            int mousePointerY = (int) StdDraw.mouseY();
            String description = w[mousePointerX][mousePointerY].description();
            StdDraw.text(2, HEIGHT - 1, description);
            StdDraw.text(65, HEIGHT - 1, "Objective: Do not step on the BOMB!");
            StdDraw.text(60, HEIGHT - 2, "Floors around the bomb will explode randomly, but some are fake!");
            StdDraw.show();
            ter.renderFrame(w);
            if (StdDraw.hasNextKeyTyped()) {
                break;
            }
        }
    }

    private void drawMainMenu() {
        Font title = new Font("Chalkboard", Font.BOLD, 27);
        StdDraw.clear(BLACK);
        StdDraw.setPenColor(Color.PINK);
        StdDraw.setFont(title);
        StdDraw.text(0.5, 0.8, "❀❀❀❀❀❀❀❀❀❀❀❀❀");
        StdDraw.text(0.5, 0.7, "CS 61B: BUILD YOUR OWN WORLD");
        StdDraw.text(0.5, 0.6, "❀❀❀❀❀❀❀❀❀❀❀❀❀");
        Font menu = new Font("Arial", Font.PLAIN, 20);
        StdDraw.setFont(menu);
        StdDraw.setPenColor(Color.gray);
        StdDraw.text(0.5, 0.35, ">> New Game (N)");
        StdDraw.setPenColor(Color.PINK);
        StdDraw.text(0.5, 0.3, "Load Game (L)");
        StdDraw.text(0.5, 0.25, "Quit (Q)");
        //StringBuilder seed = new StringBuilder();

    }

    /**
     * Method used for autograding and testing your code. The input string will be a series
     * of cs (for example, "n123sswwdasdassadwas", "n123sss:q", "lwww". The engine should
     * behave exactly as if the user typed these cs into the engine using
     * interactWithKeyboard.
     *
     * Recall that strings ending in ":q" should cause the game to quite save. For example,
     * if we do interactWithInputString("n123sss:q"), we expect the game to run the first
     * 7 commands (n123sss) and then quit and save. If we then do
     * interactWithInputString("l"), we should be back in the exact same state.
     *
     * In other words, both of these calls:
     *   - interactWithInputString("n123sss:q")
     *   - interactWithInputString("lww")
     *
     * should yield the exact same world state as:
     *   - interactWithInputString("n123sssww")
     *
     * @param input the input string to feed to your program
     * @return the 2D TETile[][] representing the state of the world
     */
    public TETile[][] interactWithInputString(String input) {
        // Fill out this method so that it run the engine using the input
        // passed in as an argument, and return a 2D tile representation of the
        // world that would have been drawn if the same inputs had been given
        // to interactWithKeyboard().
        //
        // See proj3.byow.InputDemo for a demo of how you can make a nice clean interface
        // that works for many different input types.
//        Pattern p = Pattern.compile("-?\\d+");
//        Matcher m = p.matcher(input);
//        String seed = m.group();
//        int seedValue = Integer.parseInt(seed);
//        MapGenerator map = new MapGenerator(seedValue, WIDTH, HEIGHT);
//        Random random = new Random(seedValue);
//        MapGenerator map = new MapGenerator(93123, WIDTH, HEIGHT);
//        Random random = new Random(1233123123);
        Pattern p = Pattern.compile("[0-9]+");
        Matcher m = p.matcher(input);
        long seed = 0;
        if (m.find()) {
            seed = Long.parseLong(m.group());
        }
        MapGenerator g = new MapGenerator(seed);
        g.worldGenerator();
        //ter.initialize(WIDTH, HEIGHT);
        map = g.world;
        //ter.renderFrame(finalWorldFrame);
        avatarPosition = g.avatarPoint;
        monsterPoint = g.monsterPoint;
        monster = g.monster;
        int firstS = 1;
        for (int i = 0; i < input.length(); i++) {
            if (input.charAt(i) == 's' || input.charAt(i) == 'S') {
                firstS = i + 1;
                break;
            }
        }
        for (int j = firstS; j < input.length(); j++) {
            String s = String.valueOf(input.charAt(j));
            moveAG(map, s);
            if (input.charAt(j) == 'q' && (input.charAt(j + 1) == ':')
                    || input.charAt(j) == 'Q' && (input.charAt(j + 1) == ':')) {
                save(new StringBuilder(input));
                System.out.println("Saved");
            }
            if (input.charAt(j) == 'l' || input.charAt(j) == 'L') {
                load(new StringBuilder(input));
                System.out.println("loaded prev");
            }
        }
        TETile[][] finalWorldFrame = map;
        return finalWorldFrame;

    }

    public static void main(String[] args) {
        Engine engine = new Engine();
        engine.interactWithInputString("n7193300625454684331saaawasdaawdwsd");
        System.out.println(engine);
    }

}