import de.bezier.guido.*;
public final static int NUM_ROWS =10;
public final static int NUM_COLS =10;
public final static int numBombs= 5;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons

private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    bombs = new ArrayList();
    for(int r=0; r<NUM_ROWS; r++){
      for(int c=0; c<NUM_COLS; c++)
      {
       buttons[r][c]= new MSButton(r,c); 
      }
    }
    
    setBombs();
}
public void setBombs()
{
  for(int i=0; i<numBombs; )
  {
int row=((int)(Math.random()*NUM_ROWS));
int col=((int)(Math.random()*NUM_COLS));
if(!bombs.contains(buttons[row][col])){

 bombs.add(buttons[row][col]); 
i++;
}
}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
     //your code here
    return false;
}
public void displayLosingMessage()
{
    text("Lose", 200,200);
}
public void displayWinningMessage()
{
  text("Win", 200,200);  
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT)
        {
        marked=!isMarked();
        if(marked==false)
        {
        clicked=false;
         if(bombs.contains(this))
        {
          displayLosingMessage();
        }
        } 
        }         
    }

    public void draw () 
    {    
        if (marked)
            fill(0,0,255);
         else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
     if(r>=NUM_ROWS && c>=NUM_COLS && r<10 && c<10)
     return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r,c)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r+1,c)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r-1,c)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r+1,c+1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r-1,c+1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r+1,c-1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r-1,c-1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r,c+1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        if(isValid(r,c-1)== true && bombs.contains(buttons[row][col]))
        numBombs++;
        
        
        System.out.println(numBombs);
        return numBombs;
    }
}