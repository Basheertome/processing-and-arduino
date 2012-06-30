#define ENC_A 14
#define ENC_B 15
#define ENC_PORT PINC
#define roundf

int oldcount = 0;
int diff = 0;

const int buttonPin = 8;
int buttonState = 0;
boolean buttonP = false;
int reset = 0;
boolean rotated = false;
boolean first = true;
int holding = 0;
int timeleft = 0;

int r = 0;
int g = 0;
int b = 0;
  
int fadeAmount = 5;
 
void setup()
{
  pinMode(ENC_A, INPUT);
  digitalWrite(ENC_A, HIGH);
  pinMode(ENC_B, INPUT);
  digitalWrite(ENC_B, HIGH);
  Serial.begin (115200);
  Serial.println("Start");
  
  pinMode(buttonPin, INPUT);
  
  pinMode(3, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  
  pinMode(9, OUTPUT);
}
 
void loop()
{
  
 static uint8_t counter = 0;
 int8_t tmpdata;
  tmpdata = read_encoder();
  if( tmpdata ) {
    if (oldcount < counter) {
      if (round(abs(diff) / 4.0) >= 20) {
        diff += 5;
      }
      else {diff += 1;}
    }
    else if (oldcount > counter) {
      if (round(abs(diff) / 4.0) >= 20) {
        diff -= 5;
      }
      else {diff -= 1;}
    }
    oldcount = counter;
    counter += tmpdata;
    if (round(abs(diff) / 4.0) > 99) {diff = 0;}
    Serial.println(round(abs(diff) / 4.0));
  }
  
  buttonState = digitalRead(buttonPin);
  
  if (counter != 0) {
    rotated = true;
  }
  
  if (buttonState == HIGH) {
    buttonP = true;
    holding += 1;
  }
  
  if (buttonP == false && rotated == true) {
    if (r < 255 && g < 255 && b < 255) { 
      analogWrite(3, r);
      analogWrite(5, g);
      analogWrite(6, b);
      r+= 5; g+= 5; b+= 5;
      delay(8);
    }
    else {
      analogWrite(3, 255);
      analogWrite(5, 255);
      analogWrite(6, 255);
      r = 0;
      g = 255;
      b = 0;
    }
  }
  else {
    analogWrite(6, b);
  }
  
  if (buttonP == true) {
     if (first == true) {
       r = 255;
       g = 255;
       b = 255;
       for (r;r>0;r-=5) {
         analogWrite(3, r);
         analogWrite(5, g);
         analogWrite(6, b);
         b-= 5;
         delay(8);
       }
     }
     first = false;
     rotated = false;
     analogWrite(3, r);
     analogWrite(5, g);
     r = r + fadeAmount;
     g = g - fadeAmount;
     
     int i = 0;
     while (i < 300 && holding < 50) { //Should be times 300 for minutes, 5 for seconds
       if (digitalRead(buttonPin) == HIGH) {
         holding += 1;
       }
       delay(abs(diff));
       i+=1;
     }
     
     timeleft += 1; 
     Serial.println((int) abs(round((abs(diff) / 4.0)-((timeleft * (abs(diff) / 4.0)) / 50.0))));
  }
  
  if (buttonP == true && r == 255) {
    int i;
    buzz(9, 2500, 1000);
    for (i=255;i>-1;i-=5) {
        analogWrite(3, i);
        delay(8);
      }
    analogWrite(3, 0);
    analogWrite(5, 0);
    r = 0;
    g = 0;
    counter = 0;
    diff = 0;
    buttonP = false;
    first = true;
    holding = 0;
  }
  
}
 
int8_t read_encoder()
{
  static int8_t enc_states[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
  static uint8_t old_AB = 0;
  /**/
  old_AB <<= 2;
  old_AB |= ( ENC_PORT & 0x03 );
  return ( enc_states[( old_AB & 0x0f )]);
}

void buzz(int targetPin, long frequency, long length) {
  long delayValue = 1000000/frequency/2;
  long numCycles = frequency * length/ 1000;
 for (long i=0; i < numCycles; i++){
    digitalWrite(targetPin,HIGH);
    delayMicroseconds(delayValue);
    digitalWrite(targetPin,LOW);
    delayMicroseconds(delayValue);
  }
}

