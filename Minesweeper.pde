import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS=20;
private final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  // make the manager
  Interactive.make( this );
  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y < NUM_ROWS; y++)
    for (int x = 0; x< NUM_COLS; x++)
      buttons[x][y] = new MSButton(x, y);
  bombs = new ArrayList <MSButton>();
  setBombs();
}
public void setBombs()
{
  int x = 0;
  while ( x<=40)
  {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[row][col]))
    {
      bombs.add(buttons[row][col]);
    }   //your code
    x++;
  }
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
       if(keyPressed && key =='r'){
    for (int y = bombs.size()-1; y>=0; y--) {
      bombs.remove(y);
    }
    for (int i = 0; i< NUM_ROWS; i++) {
      for (int x = 0; x < NUM_COLS; x++) {
        buttons[i][x].setLabel("");
        buttons[i][x].clicked =false;
        buttons[i][x].marked =false;
      }
    } 
    setBombs();
  }
  }

public boolean isWon()
{
  for (int i =0; i< NUM_ROWS; i++)
    for (int y = 0; y < NUM_COLS; y++)
      if (bombs.contains(buttons[i][y])&& !buttons[i][y].isMarked())
        return false;
  return true;
}
public void displayLosingMessage()
{
  for (int i = 0; i< NUM_ROWS; i++)
    for (int x = 0; x < NUM_COLS; x++)
      if (bombs.contains(buttons[i][x])&& !buttons[i][x].isClicked())
      {
        buttons[i][x].marked=false;
        buttons[i][x].clicked=true;
      }
  buttons[10][6].label="y";
  buttons[10][7].label="o";
  buttons[10][8].label="u";
  buttons[10][10].label="l";
  buttons[10][11].label="o";
  buttons[10][12].label="s";
  buttons[10][13].label="e";
  //your code here
}
public void displayWinningMessage()
{
  buttons[10][6].label="y";
  buttons[10][7].label="o";
  buttons[10][8].label="u";
  buttons[10][10].label="w";
  buttons[10][11].label="i";
  buttons[10][12].label="n";
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
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
    if (mouseButton == RIGHT)
      marked = !marked;
    else if (bombs.contains( this ))
      displayLosingMessage();
    else if (countBombs(r, c)!= 0)
    {
      fill(255);
      setLabel(str(countBombs(r, c)));
    } else {
      if (isValid(r, c-1) && !buttons[r][c-1].isClicked()) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && !buttons[r][c+1].isClicked()) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c) && !buttons[r-1][c].isClicked()) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r+1, c) && !buttons[r+1][c].isClicked()) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked()) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked()) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked()) {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked()) {
        buttons[r+1][c+1].mousePressed();
      }
      //your code here
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r >= 0 && r < NUM_ROWS && c>=0 && c <NUM_COLS)
      return true;
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(r-1, c) && bombs.contains(buttons[row-1][col])) {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c])) {
      numBombs++;
    }
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1])) {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1])) {
      numBombs++;
    }
    if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1])) {
      numBombs++;
    }
    if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1])) {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1])) {
      numBombs++;
    }
    //your code here
    return numBombs;
  }
}
