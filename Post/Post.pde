// Enter in your imap email login information inbetween the quotes

String email = "basheertome@gmail.com";
String password = "6A15a421778Ce35BaE88";
String mailbox = "INBOX";

// ---------------------------------------------------------------

import processing.serial.*;
import cc.arduino.*;

import javax.mail.*;
import javax.mail.internet.*;

Arduino arduino;

boolean newmail = false;

void setup() {
  size(200,200);
  arduino = new Arduino(this, Arduino.list()[4], 57600);

  try {
    Properties props = System.getProperties();
    props.setProperty("mail.store.protocol", "imaps");
    Session session = Session.getDefaultInstance(props, null);
    Store store = session.getStore("imaps");
    store.connect("imap.gmail.com", email, password);
    
    Folder folder = store.getFolder(mailbox);
    folder.open(Folder.READ_ONLY);
    FlagTerm ft = new FlagTerm(new Flags(Flags.Flag.SEEN), false);
    Message messages[] = folder.search(ft);
    
    if (messages.length > 0) {
      newmail = true;
    } else {
      newmail = false;
    }
    
    folder.close(false);
    store.close();
  } 

  catch (Exception e) {
    e.printStackTrace();
  }

  noLoop();
}

void draw() {
  if (newmail) {
    arduino.analogWrite(6, 255);
    arduino.analogWrite(5, 255);
    arduino.analogWrite(3, 255);
    arduino.analogWrite(9, 135);
  } else {  
    arduino.analogWrite(6, 0);
    arduino.analogWrite(5, 0);
    arduino.analogWrite(3, 0);
    arduino.analogWrite(9, 0);
  }
}
