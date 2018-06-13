/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chachachachi;

import java.awt.Color;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author user
 */
public class GestionPagos extends javax.swing.JPanel {

    public Connection connection() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection conexion
                    = DriverManager.getConnection("jdbc:mysql://localhost/ChachaChachi",
                            "root", "");
            return conexion;
        } catch (ClassNotFoundException | SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Planificar.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     * Creates new form GestionPagos
     */
    public GestionPagos() {
        initComponents();
        this.setBackground(Color.WHITE);
        this.txtFechaPago.setEnabled(false);
        this.txtFechaPago.setEditable(false);
        this.txtTiempoPago.setEnabled(false);
        this.txtTiempoPago.setEditable(false);
        this.txtPrecio.setEnabled(false);
        this.txtPrecio.setEditable(false);

        Fillcombo();

    }

    private void Fillcombo() {
        try {
            Connection conexion = connection();

            try (
                    Statement sentencia = conexion.createStatement()) {

                String usarBD = "USE chachachachi;";
                sentencia.executeUpdate(usarBD);
                ResultSet result = sentencia.executeQuery("SELECT nombre FROM empleado");

                while (result.next()) {
                    cbEmpleados.addItem(result.getString(1));
                    System.out.println("name " + result.getString(1));
                }
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    private void getDate() {
        String name = cbEmpleados.getSelectedItem().toString();
        System.out.println(name);
        try {
            Connection conexion = connection();

            Statement sentencia = conexion.createStatement();

            String usarBD = "USE chachachachi;";
            sentencia.executeUpdate(usarBD);
            ResultSet result = sentencia.executeQuery("SELECT MAX(tr.fecha)\n"
                    + "FROM empleado e, empleado_sala_tarea est, tarea_realizada tr\n"
                    + "WHERE e.P_empleado = est.A_empleado\n"
                    + "AND e.nombre = '" + name + "' AND tr.pagada = true");

            while (result.next()) {
                this.txtFechaPago.setText(result.getString(1));
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    private void precioHora() {
        String name = cbEmpleados.getSelectedItem().toString();
        System.out.println(name);
        try {
            Connection conexion = connection();

            Statement sentencia = conexion.createStatement();

            String usarBD = "USE chachachachi;";
            sentencia.executeUpdate(usarBD);
            ResultSet result = sentencia.executeQuery("SELECT e.precioHora \n"
                    + "FROM empleado e \n"
                    + "WHERE e.nombre = '" + name + "'");

            while (result.next()) {
                this.txtPrecio.setText(result.getString(1));
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    private void tiempoTrabajado() {
        String name = cbEmpleados.getSelectedItem().toString();
        String fecha = txtFechaPago.getText();
        System.out.println(name);
        try {
            Connection conexion = connection();

            Statement sentencia = conexion.createStatement();

            String usarBD = "USE chachachachi;";
            sentencia.executeUpdate(usarBD);
            //tiempotrabajado desde la fecha
            ResultSet result = sentencia.executeQuery("SELECT SUM(tr.duracion_min)\n"
                    + "FROM empleado_sala_tarea est, empleado e , tarea_realizada tr\n"
                    + "WHERE e.nombre = '" + name + "' AND tr.fecha>='" + fecha + "'");

            while (result.next()) {
                this.txtTiempoPago.setText(result.getString(1));
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    public void total() {

        int pHoras = Integer.parseInt(txtPrecio.getText());
        int minTrabajados = Integer.parseInt(txtTiempoPago.getText());
        int hTrabajadas = minTrabajados / 60;
        System.out.println("Horas " + hTrabajadas);
        int total = hTrabajadas * pHoras;
        String text = Integer.toString(total);
        txtTotal.setText(text);
        System.out.println("Total  " + total);
    }

    public void pagar() throws SQLException {

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDate localDate = LocalDate.now();
        System.out.println(dtf.format(localDate));

        try {
//Creamos la conexión
            Connection conexion = connection();

            //Creamos la sentencia
            Statement sentencia = conexion.createStatement();

            //Usar la base de datos
            String usarBD = "USE chachachachi;";
            sentencia.executeUpdate(usarBD);

            conexion.setAutoCommit(false);
            String name = cbEmpleados.getSelectedItem().toString();
            String tiempoTrabajado = txtTiempoPago.getText();
            String fecha = txtFechaPago.getText();
            String sql = "UPDATE tarea_realizada\n"
                    + "SET\n"
                    + "tr.fecha = '" + dtf.format(localDate) + "'\n"
                    + "WHERE\n"
                    + "tr.fecha = (\n"
                    + "SELECT MAX(tr.fecha)\n"
                    + "FROM empleado e, empleado_sala_tarea est, tarea_realizada tr\n"
                    + "WHERE e.P_empleado = est.A_empleado\n"
                    + "AND e.nombre = '" + name + "' AND tr.pagada = false;";
            System.out.println(sql);
            sentencia.executeUpdate(sql);
                        
            JOptionPane.showMessageDialog(null, "No tiene pagos pendientes");
            //Actualizar fecha del último pago

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }

    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel2 = new javax.swing.JLabel();
        cbEmpleados = new javax.swing.JComboBox<>();
        txtFechaPago = new javax.swing.JTextField();
        txtTiempoPago = new javax.swing.JTextField();
        txtPrecio = new javax.swing.JTextField();
        btnPagar = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        txtTotal = new javax.swing.JTextField();
        jLabel6 = new javax.swing.JLabel();

        jLabel2.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel2.setText("Seleccione un empleado: ");

        cbEmpleados.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        cbEmpleados.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cbEmpleadosActionPerformed(evt);
            }
        });

        txtFechaPago.setEditable(false);
        txtFechaPago.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        txtFechaPago.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtFechaPagoActionPerformed(evt);
            }
        });

        txtTiempoPago.setEditable(false);
        txtTiempoPago.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N

        txtPrecio.setEditable(false);
        txtPrecio.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        txtPrecio.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtPrecioActionPerformed(evt);
            }
        });

        btnPagar.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        btnPagar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/cash.png"))); // NOI18N
        btnPagar.setText("PAGAR");
        btnPagar.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnPagarMouseClicked(evt);
            }
        });

        jLabel3.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel3.setText("Fecha del último pago:");

        jLabel4.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel4.setText("Tiempo trabajado(min):");

        jLabel5.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel5.setText("Precio por horas:");

        txtTotal.setEditable(false);
        txtTotal.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N

        jLabel6.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel6.setText("TOTAL:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(32, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cbEmpleados, javax.swing.GroupLayout.PREFERRED_SIZE, 157, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtFechaPago, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel3, javax.swing.GroupLayout.Alignment.LEADING))
                        .addGap(40, 40, 40)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel6)
                            .addComponent(txtTotal, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtTiempoPago, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(jLabel4))
                                .addGap(40, 40, 40)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(txtPrecio, javax.swing.GroupLayout.PREFERRED_SIZE, 183, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(jLabel5))))))
                .addContainerGap(32, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnPagar)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cbEmpleados, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel2))
                .addGap(51, 51, 51)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel5)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(jLabel4))
                        .addGap(10, 10, 10)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtFechaPago, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(txtTiempoPago, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(txtPrecio, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))))
                .addGap(45, 45, 45)
                .addComponent(jLabel6)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtTotal, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(35, 35, 35)
                .addComponent(btnPagar)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void txtFechaPagoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtFechaPagoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtFechaPagoActionPerformed

    private void txtPrecioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtPrecioActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtPrecioActionPerformed

    private void cbEmpleadosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cbEmpleadosActionPerformed
        // TODO add your handling code here:
        this.txtFechaPago.setText("");
        this.txtPrecio.setText("");
        this.txtTiempoPago.setText("");
        getDate();
        precioHora();
        tiempoTrabajado();
        total();
    }//GEN-LAST:event_cbEmpleadosActionPerformed

    private void btnPagarMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnPagarMouseClicked
        try {
            // TODO add your handling code here:
            pagar();
        } catch (SQLException ex) {
            Logger.getLogger(GestionPagos.class.getName()).log(Level.SEVERE, null, ex);
        }
        txtTiempoPago.setText("0");
        txtTotal.setText("0");
    }//GEN-LAST:event_btnPagarMouseClicked


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel btnPagar;
    private javax.swing.JComboBox<String> cbEmpleados;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JTextField txtFechaPago;
    private javax.swing.JTextField txtPrecio;
    private javax.swing.JTextField txtTiempoPago;
    private javax.swing.JTextField txtTotal;
    // End of variables declaration//GEN-END:variables
}
