import codeanticode.eliza.*;

Eliza eliza;
PFont font;
String elizaResponse, humanResponse;
boolean showCursor;
int lastTime;

void setup()
{
    size(400, 400);
    eliza = new Eliza(this);
  

    //eliza.readScript("script");
    //eliza.readScript("http://chayden.net/eliza/script");
  
  eliza.readScript("elizaresponse.txt");
    font = loadFont("Rockwell-24.vlw");
    textFont(font);

    printElizaIntro();
    humanResponse = "";
    showCursor = true;
    lastTime = 0;
}

void draw()
{
    background(102);

    fill(255);
    text(elizaResponse, 10, 50, width - 40, height);

    fill(0);

    int t = millis();
    if (t - lastTime > 500)
    {
        showCursor = !showCursor;
        lastTime = t;
    }
    
    if (showCursor) text(humanResponse + "_", 10, 150, width - 40, height);
    else text(humanResponse, 10, 150, width - 40, height);
}

void keyPressed() 
{
    if ((key == ENTER) || (key == RETURN)) 
    {
        println(humanResponse);
        elizaResponse = eliza.processInput(humanResponse);
        println(">> " + elizaResponse);
        humanResponse = "";
    } 
    else if ((key > 31) && (key != CODED)) 
    {
        humanResponse = humanResponse + key;
    }
    else if ((key == BACKSPACE) && (0 < humanResponse.length()))
    {
        char c = humanResponse.charAt(humanResponse.length() - 1);
        humanResponse = humanResponse.substring(0, humanResponse.length() - 1);
    }
}

void printElizaIntro()
{
    String hello = "Hello.";
    elizaResponse = hello + " " + eliza.processInput(hello);
    println(">> " + elizaResponse);
}