package dao;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailDAO {
	public void send(String to, String sub, String msg, final String user, final String pass) {
		try {
			//create an instance of Properties Class   
			Properties props = new Properties();
			props.propertyNames();
			/* Specifies the IP address of your default mail server
			   for e.g if you are using gmail server as an email sever
			  you will pass smtp.gmail.com as value of mail.smtp host. 
			  As shown here in the code. 
			  Change accordingly, if your email id is not a gmail id
			*/
			
			props.put("mail.smtp.host", "smtp.gmail.com");
			//below mentioned mail.smtp.port is optional
			props.put("mail.smtp.port", "465");		
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.fallback", "false");
			/* Pass Properties object(props) and Authenticator object   
			  for authentication to Session instance 
			*/

			Session mailSession = Session.getInstance(props, null);
			mailSession.setDebug(true);

			MimeMessage mailMessage = new MimeMessage(mailSession);
			mailMessage.setFrom(new InternetAddress(user));
			mailMessage.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
			mailMessage.setContent(msg, "text/html; charset=UTF-8");
			mailMessage.setSubject(sub,"UTF-8");

			/* Transport class is used to deliver the message to the recipients */
			Transport transport = mailSession.getTransport("smtp");
			transport.connect("smtp.gmail.com", user, pass);
			transport.sendMessage(mailMessage, mailMessage.getAllRecipients());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
