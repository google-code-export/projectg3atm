package ATM;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.Timer;

/**
 *
 * @author User
 */
public class Time {
    Timer time;
    String th;
    int ye, mo, da, ho, mi, se;
    Date todayD = new Date(System.currentTimeMillis());
    SimpleDateFormat the, years, months, days, hours, minutes, seconds;
    int delay = 1000;
    public void  Time(){
        the = new SimpleDateFormat("EE");
        years = new SimpleDateFormat("yyyy");
        months = new SimpleDateFormat("MM");
        days = new SimpleDateFormat("dd");
        hours = new SimpleDateFormat("HH");
        minutes = new SimpleDateFormat("mm");
        seconds = new SimpleDateFormat("ss");
//parse ngay thang sang dinh dang va chuyen thanh int.
        th = the.format(todayD.getTime());
        ye = Integer.parseInt(years.format(todayD.getTime()));
        mo = Integer.parseInt(months.format(todayD.getTime()));
        da = Integer.parseInt(days.format(todayD.getTime()));
        ho = Integer.parseInt(hours.format(todayD.getTime()));
        mi = Integer.parseInt(minutes.format(todayD.getTime()));
        se = Integer.parseInt(seconds.format(todayD.getTime()));
        ActionListener taskPerformer = new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                se++;
                if (se == 60) {
                    se = 0;
                    mi++;
                }
                if (mi == 60) {
                    se = 0;
                    mi = 0;
                    ho++;
                }
                if (ho == 24) {
                    se = 0;
                    mi = 0;
                    ho = 0;
                    da++;
                }
                if (mo == 1 || mo == 3 || mo == 5 || mo == 7 || mo == 8 || mo == 10 || mo == 12) {
                    if (da == 31) {
                        se = 0;
                        mi = 0;
                        ho = 0;
                        da = 1;
                        mo++;
                    }
                } else if (mo == 2 && (ye % 4) == 0) {
                    if (da == 29) {
                        se = 0;
                        mi = 0;
                        ho = 0;
                        da = 1;
                        mo++;
                    }
                } else if (mo == 2 && (ye % 4) != 0) {
                    if (da == 28) {
                        se = 0;
                        mi = 0;
                        ho = 0;
                        da = 1;
                        mo++;
                    }
                } else if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
                    if (da == 30) {
                        se = 0;
                        mi = 0;
                        ho = 0;
                        da = 1;
                        mo++;
                    }
                }
                if (mo == 12) {
                    se = 0;
                    mi = 0;
                    ho = 0;
                    da = 1;
                    mo = 1;
                    ye++;
                }
            }
        };
        new Timer(delay, taskPerformer).start();
    }
}
