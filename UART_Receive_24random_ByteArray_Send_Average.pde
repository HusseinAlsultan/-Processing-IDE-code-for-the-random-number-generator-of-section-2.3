import processing.serial.*;



Serial myPort;            // The serial port:

byte[] myData = new byte[24];
int index = 0;
int myDataSum = 0;
byte myDataAverage;
byte inByte;

void setup() {
  myPort = new Serial(this, Serial.list()[0], 115200);          // Open COM5
  myPort.clear();
}



void draw() {
  //do nothing
}

void serialEvent(Serial myPort) {
  if (myPort.available() > 0) {
    inByte = byte(myPort.read());
    if (char(inByte) == 'I') {
      myPort.clear();
      delay(50);
      myPort.write('A');
    } else {
      myData[index] = inByte;
      myDataSum = myDataSum + int(myData[index]);
      print(myData[index] + ", ");
      index++;
    }
    if (index == 24) {
      sendAverage();
    }
  }
}

void sendAverage() {
  myPort.clear();
  myDataAverage = byte(myDataSum / 24);
  println("\nData average: " + myDataAverage);
  myPort.write(myDataAverage);
  index = 0;
  myDataSum = 0;
}
