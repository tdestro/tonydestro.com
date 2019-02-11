package ae_ContinualIntergration;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;

import static java.nio.file.StandardCopyOption.*;

import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.DataNode;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
public class Ae_ContinualIntergration {
	  
	// THIS IS A AUTOMATED DEPLOYMENT AND INTEGRATION SCRIPT THAT DOES A LOT OF WORK FOR ME 
	// SO I DON'T
	public static String getobj(Elements scriptElements){ 
    	String tempstring ="";
   
    	 for (Element element :scriptElements ){                
    	        for (DataNode node : element.dataNodes()) {
    	            tempstring += node.getWholeData();
    	        }          
    	  }
    	 
    return	"{"+tempstring.substring(tempstring.indexOf("{") + 1, tempstring.indexOf("}"))+"}";
    	 
	}
    public static void main(String[] args) throws IOException, InterruptedException {
    	
    	String integrationString = "";
    	String objectStringMen = "var objectStringMen_1903 = [";
    	String objectStringWomen = "var objectStringWomen_1903 = [";
    	
    	String wdir = System.getProperty("user.dir");
    	
    	
    	File input = new File(wdir+"/../parallax/core.html");
    	Document doc = Jsoup.parse(input, "UTF-8");
    	Element content = doc.getElementById("aeobtsflx-core");
    	Element ul = doc.getElementById("aeobtsflx-scene");
    	content.prepend("<!-- CORE MENS -->");

    	content.attr("id", "parallaxMen0_1903");
    	ul.attr("id", "parallaxMen0Scene_1903");
    	integrationString += content;
    	Elements scriptElements = doc.getElementsByTag("script");
    	objectStringMen += getobj(scriptElements)+",";
    	
    	
    	input = new File(wdir+"/../parallax/active.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-active");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.prepend("<!-- ACTIVE MENS -->");
    	content.attr("id", "parallaxMen1_1903");
    	ul.attr("id", "parallaxMen1Scene_1903");
    	integrationString +=  content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringMen += getobj(scriptElements)+",";
    	
    	input = new File(wdir+"/../parallax/extreme.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-extreme");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxMen2_1903");
    	ul.attr("id", "parallaxMen2Scene_1903");
    	content.prepend("<!-- EXTREME MENS -->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringMen += getobj(scriptElements)+",";
    	
    	input = new File(wdir+"/../parallax/flexdenim_endslate.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-flexdenim");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxMen3_1903");
    	ul.attr("id", "parallaxMen3Scene_1903");
    	content.prepend("<!-- Flex end slate -->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringMen += getobj(scriptElements)+"];";
    	 System.out.println(objectStringMen);
    	
    	input = new File(wdir+"/../parallax/x4.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-x4");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxWomen0_1903");
    	ul.attr("id", "parallaxWomen0Scene_1903");
    	content.prepend("<!-- x4 womens-->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringWomen += getobj(scriptElements)+",";
    	
    	input = new File(wdir+"/../parallax/sateen.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-sateen");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxWomen1_1903");
    	ul.attr("id", "parallaxWomen1Scene_1903");
    	content.prepend("<!-- sateen womens -->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringWomen += getobj(scriptElements)+",";
    	
    	input = new File(wdir+"/../parallax/x.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("aeobtsflx-x");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxWomen2_1903");
    	ul.attr("id", "parallaxWomen2Scene_1903");
    	content.prepend("<!-- x womens -->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringWomen += getobj(scriptElements)+",";
    	
    	input = new File(wdir+"/../parallax/denimx_endslate.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	content = doc.getElementById("container");
    	ul = doc.getElementById("aeobtsflx-scene");
    	content.attr("id", "parallaxWomen3_1903");
    	ul.attr("id", "parallaxWomen3Scene_1903");
    	content.prepend("<!-- denim x endslate -->");
    	integrationString += content;
    	scriptElements = doc.getElementsByTag("script");
    	objectStringWomen += getobj(scriptElements)+"];";
    	System.out.println(objectStringWomen);
    	
    	input = new File(wdir+"/../index.html");
    	doc = Jsoup.parse(input, "UTF-8");
    	doc.getElementById("parallaxWomen0_1903").remove();
    	doc.getElementById("parallaxWomen1_1903").remove();
    	doc.getElementById("parallaxWomen2_1903").remove();
    	doc.getElementById("parallaxWomen3_1903").remove();
    	doc.getElementById("parallaxMen0_1903").remove();
    	doc.getElementById("parallaxMen1_1903").remove();
    	doc.getElementById("parallaxMen2_1903").remove();
    	doc.getElementById("parallaxMen3_1903").remove();
    	doc.getElementById("objects_1903").remove();
    	
    	integrationString  += "<script id='objects_1903'>"+ objectStringWomen + " "+ objectStringMen +"</script>";
 
    	FileUtils.deleteDirectory(new File(wdir+"/../images"));
    	FileUtils.copyDirectory(new File(wdir+"/../parallax/images"), new File(wdir+"/../images"));
    	Files.copy( FileSystems.getDefault().getPath(wdir+"/../parallax/styles/styles.css"),  Paths.get(wdir+"/../styles/styles.css"), REPLACE_EXISTING);
    	String csscontent = FileUtils.readFileToString(new File(wdir+"/../styles/styles.css"));

    	 Matcher m = Pattern.compile(".*?url\\(\\.\\.(.+?)\\);[.*]*")
    	     .matcher(csscontent);
    	 integrationString += "<!-- $.preloadImages(";
    	 while (m.find()) {
    		 integrationString += "\""+m.group(1).substring(1)+"\",";
    	 }
    	 integrationString += "); -->";
 
 Element div = doc.select("body").first();
    	div.prepend(integrationString);
      	FileUtils.writeStringToFile(new File(wdir+"/../index.html"), doc.outerHtml());
      	final Process k = Runtime.getRuntime().exec(new String[] { "/bin/bash", "-c", "find . -name '*.jpg' -exec /usr/local/Cellar/mozjpeg/3.0/bin/cjpeg -quality 80 -optimize -outfile '"+wdir+"/../optimized/{}' {} \\;"}, null, new File(wdir+"/../images"));
      	FileUtils.copyDirectory(new File(wdir+"/../optimized"), new File(wdir+"/../images"));
      	
    	final Process p = Runtime.getRuntime().exec(new String[] { "/bin/bash", "-c", "/usr/local/bin/pngquant --ext .png --verbose --speed 1 --force 256  "+wdir+"/../images/*.png |grep -vi \"x-maia\""}, null, new File(wdir+"/../images"));

    	
    	String line;

    	BufferedReader error = new BufferedReader(new InputStreamReader(p.getErrorStream()));
    	while((line = error.readLine()) != null){
    	    System.out.println(line);
    	}
    	error.close();

    	BufferedReader input1 = new BufferedReader(new InputStreamReader(p.getInputStream()));
    	while((line=input1.readLine()) != null){
    	    System.out.println(line);
    	}
    	p.waitFor();
    	input1.close();
    	
    	

    	OutputStream outputStream = p.getOutputStream();
    	PrintStream printStream = new PrintStream(outputStream);
    	printStream.println();
    	printStream.flush();
    	printStream.close();
    	System.out.println("done with pngquant");
    	
    	final Process j = Runtime.getRuntime().exec(new String[] { "/bin/bash", "-c", "/usr/local/bin/node /Users/anthonyodestro/Downloads/zopfli-png-master/zopfli-png --i500 "+wdir+"/../images/*.png"}, null, new File(wdir+"/../images"));

    	String line1;

    	BufferedReader error1 = new BufferedReader(new InputStreamReader(j.getErrorStream()));
    	while((line1 = error1.readLine()) != null){
    	    System.out.println(line1);
    	}
    	error1.close();

    	BufferedReader input2  = new BufferedReader(new InputStreamReader(j.getInputStream()));
    	while((line1=input2.readLine()) != null){
    	    System.out.println(line1);
    	}
    	 j.waitFor();
    	input2.close();

    	OutputStream outputStream1 = j.getOutputStream();
    	PrintStream printStream1 = new PrintStream(outputStream1);
    	printStream1.println();
    	printStream1.flush();
    	printStream1.close();
    	System.out.println("done with zopfli-png");
    	
     
    	/*
    	 String server = "1903host.com";
         int port = 21;
         String user = "tony";
         String pass = "Q%5ume48";
  
         FTPClient ftpClient = new FTPClient();
  
         try {
             // connect and login to the server
             ftpClient.connect(server, port);
             ftpClient.login(user, pass);
  
             // use local passive mode to pass firewall
             ftpClient.enterLocalPassiveMode();
  
             System.out.println("Connected");
  
             String remoteDirPath = "/httpdocs/ae";
             String localDirPath = "/Library/WebServer/Documents";
             removeDirectory(ftpClient, remoteDirPath, "");
             ftpClient.makeDirectory(remoteDirPath);
             uploadDirectory(ftpClient, remoteDirPath, localDirPath, "");
  
             // log out and disconnect from the server
             ftpClient.logout();
             ftpClient.disconnect();
  
             System.out.println("Disconnected");
         } catch (IOException ex) {
             ex.printStackTrace();
         }
    	*/
    	
    }
    
    /**
     * Upload a whole directory (including its nested sub directories and files)
     * to a FTP server.
     *
     * @param ftpClient
     *            an instance of org.apache.commons.net.ftp.FTPClient class.
     * @param remoteDirPath
     *            Path of the destination directory on the server.
     * @param localParentDir
     *            Path of the local directory being uploaded.
     * @param remoteParentDir
     *            Path of the parent directory of the current directory on the
     *            server (used by recursive calls).
     * @throws IOException
     *             if any network or IO error occurred.
     */
    public static void uploadDirectory(FTPClient ftpClient,
            String remoteDirPath, String localParentDir, String remoteParentDir)
            throws IOException {
     
        System.out.println("LISTING directory: " + localParentDir);
     
        File localDir = new File(localParentDir);
        File[] subFiles = localDir.listFiles();
        if (subFiles != null && subFiles.length > 0) {
            for (File item : subFiles) {
                String remoteFilePath = remoteDirPath + "/" + remoteParentDir
                        + "/" + item.getName();
                if (remoteParentDir.equals("")) {
                    remoteFilePath = remoteDirPath + "/" + item.getName();
                }
     
     
                if (item.isFile()) {
                    // upload the file
                    String localFilePath = item.getAbsolutePath();
                    System.out.println("About to upload the file: " + localFilePath);
                    boolean uploaded = uploadSingleFile(ftpClient,
                            localFilePath, remoteFilePath);
                    if (uploaded) {
                        System.out.println("UPLOADED a file to: "
                                + remoteFilePath);
                    } else {
                    	
                    	System.out.println(ftpClient.getReplyString());
                        System.out.println("COULD NOT upload the file: "
                                + localFilePath);
                    }
                } else {
                    // create directory on the server
                    boolean created = ftpClient.makeDirectory(remoteFilePath);
                    if (created) {
                        System.out.println("CREATED the directory: "
                                + remoteFilePath);
                    } else {
                        System.out.println("COULD NOT create the directory: "
                                + remoteFilePath);
                        System.out.println(ftpClient.getReplyString());
                    }
     
                    // upload the sub directory
                    String parent = remoteParentDir + "/" + item.getName();
                    if (remoteParentDir.equals("")) {
                        parent = item.getName();
                    }
     
                    localParentDir = item.getAbsolutePath();
                    uploadDirectory(ftpClient, remoteDirPath, localParentDir,
                            parent);
                }
            }
        }
    }
    
    
    /**
     * Upload a single file to the FTP server.
     *
     * @param ftpClient
     *            an instance of org.apache.commons.net.ftp.FTPClient class.
     * @param localFilePath
     *            Path of the file on local computer
     * @param remoteFilePath
     *            Path of the file on remote the server
     * @return true if the file was uploaded successfully, false otherwise
     * @throws IOException
     *             if any network or IO error occurred.
     */
    public static boolean uploadSingleFile(FTPClient ftpClient,
            String localFilePath, String remoteFilePath) throws IOException {
    	
    	if(localFilePath.contains("prores")) return false;
        File localFile = new File(localFilePath);
     
        InputStream inputStream = new FileInputStream(localFile);
        try {
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
            return ftpClient.storeFile(remoteFilePath, inputStream);
        } finally {
            inputStream.close();
        }
    }
    
    /**
     * Removes a non-empty directory by delete all its sub files and
     * sub directories recursively. And finally remove the directory.
     */
    public static void removeDirectory(FTPClient ftpClient, String parentDir,
            String currentDir) throws IOException {
        String dirToList = parentDir;
        if (!currentDir.equals("")) {
            dirToList += "/" + currentDir;
        }
 
        FTPFile[] subFiles = ftpClient.listFiles(dirToList);
 
        if (subFiles != null && subFiles.length > 0) {
            for (FTPFile aFile : subFiles) {
                String currentFileName = aFile.getName();
                if (currentFileName.equals(".") || currentFileName.equals("..")) {
                    // skip parent directory and the directory itself
                    continue;
                }
                String filePath = parentDir + "/" + currentDir + "/"
                        + currentFileName;
                if (currentDir.equals("")) {
                    filePath = parentDir + "/" + currentFileName;
                }
 
                if (aFile.isDirectory()) {
                    // remove the sub directory
                    removeDirectory(ftpClient, dirToList, currentFileName);
                } else {
                    // delete the file
                    boolean deleted = ftpClient.deleteFile(filePath);
                    if (deleted) {
                        System.out.println("DELETED the file: " + filePath);
                    } else {
                        System.out.println("CANNOT delete the file: "
                                + filePath);
                    }
                }
            }
 
            // finally, remove the directory itself
            boolean removed = ftpClient.removeDirectory(dirToList);
            if (removed) {
                System.out.println("REMOVED the directory: " + dirToList);
            } else {
                System.out.println("CANNOT remove the directory: " + dirToList);
            }
        }
    }
}
