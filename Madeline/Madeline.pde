//int ledPins[6] = {3, 11, 10, 9, 6, 5};
int ledPins[6] = {5, 6, 9, 10, 11, 3};
int brightness[6] = {10, 50, 100, 150, 200, 250};
int fadeAmount[6] = {5, 5, 5, 5, 5, 5};
int offCounter[6] = {0, 0, 0, 0, 0, 0};
int fadeUpAmount = 7;
int fadeDownAmount = -14;

void setup () {
  pinMode(3, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
}

void loop() {
  for (int b = 0; b < 6; b++) {
    analogWrite(ledPins[b], brightness[b]);
    brightness[b] = brightness[b] + fadeAmount[b];
    if (brightness[b] <= 10) {
      brightness[b] = 10;
      if (offCounter[b] < 50) {
         offCounter[b]++;
      }
      else {
        fadeAmount[b] = fadeUpAmount;
        offCounter[b] = 0;
      }
    }
    if (brightness[b] >= 255) {
      fadeAmount[b] = fadeDownAmount; 
      brightness[b] = 255;
    }
  }
  delay(30);
}
