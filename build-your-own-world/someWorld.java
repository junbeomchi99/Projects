package byow.Core;



import byow.TileEngine.TETile;


import javax.swing.text.Position;
import java.io.Serializable;



public class someWorld implements Serializable {

    private Position lockedDoor;
    private Position player;
    private TETile[][] world;



    public someWorld(Position l, Position p, TETile[][] w) {
        this.lockedDoor = l;
        this.player = p;
        this.world = w;
    }



    public Position lockedDoor() {
        return this.lockedDoor;
    }
    public Position player() {
        return this.player;
    }
    public TETile[][] world() {
        return this.world;
    }

}