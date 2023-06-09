import processing.serial.*;

Serial myPort;            // The serial port:
byte [] myData = new byte[24];
byte receivedAverage;
byte inByte;
byte myDataAverage = 0;
boolean firstContact = false;

void setup() {
  myPort = new Serial(this, Serial.list()[2], 115200);          // Open COM5
  establishContact(); // send a byte to establish contact until receiver responds
  myPort.clear();
}

void draw() {
  // do nothing;
}

void establishContact() {
  while (myPort.available() <= 0) {
    myPort.write('I');   // send a capital I
    delay(50);
  }
}

void serialEvent(Serial myPort) {
//  if (myPort.available() > 0) {
    inByte = byte(myPort.read());
    if (char(inByte) == 'A' && (!firstContact)) {
      myPort.clear();
      firstContact = true;
      SendData();
      
    }
    else if (char(inByte) != 'A') {
      receivedAverage = inByte;
      println("Received Average is: " + receivedAverage);
      delay(100);
      SendData();
    }
//  }
}

void SendData() {
  int myDataSum = 0;
  for (int i = 0; i < 24; i++) {
    myData[i] = byte(random(0, 39));
    myPort.write(myData[i]);
    myDataSum = myDataSum + int(myData[i]);
    print(myData[i] + ", ");
    delay(100);
  }
  myDataAverage = byte(myDataSum / 24);
  println("\nData average: " + myDataAverage);
  myDataSum = 0;
}
