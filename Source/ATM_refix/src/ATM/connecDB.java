package ATM;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class connecDB {

    Connection con;
    Statement sta;
    File f;
    Properties pr;
    BufferedReader br = null;
    BufferedWriter bw = null;
    String server, db, id, pass;
    FixConnection fc;
    public void connecDB() {
        f = new File("D:\\Connection.txt");
        if (f.exists()) {
            try {
                br = new BufferedReader(new FileReader(f));
                pr = new Properties();
                pr.load(br);
                server = pr.getProperty("server");
                db = pr.getProperty("db");
                id = pr.getProperty("id");
                pass = pr.getProperty("pass");
                br.close();
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                con = DriverManager.getConnection(server + db, id, pass);
                sta = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
                new FixConnection().setVisible(false);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(connecDB.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(connecDB.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(connecDB.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (!f.exists()) {
            fc = new FixConnection();
            fc.setVisible(true);
        }
    }


}
