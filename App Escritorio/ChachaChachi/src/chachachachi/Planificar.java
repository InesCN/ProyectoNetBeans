/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package chachachachi;

import chachachachi.entidades.Sala;
import chachachachi.entidades.Tarea;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Clock;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultListModel;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeCellRenderer;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

/**
 *
 * @author dam205
 */
public final class Planificar extends javax.swing.JPanel {

    String turno;
    String usuario;
    boolean guardado = false; //Cuando es igual a false no está guardado

    int cocina = 1;
    int sala = 2;
    int bano = 3;
    int habitacion1 = 4;
    int habitacion2 = 5;
    int alacena = 6;
    int cuartoEstudio = 7;

    DefaultListModel listaTareasModelo = new DefaultListModel();
    DefaultListModel listaEstanciasModelo = new DefaultListModel();

    /**
     * Creates new form Tareas
     *
     */
    public Planificar() {
        initComponents();

        listaTareas.setModel(listaTareasModelo);
        listaEstancias.setModel(listaEstanciasModelo);

        decorarJTree();

        obtenerTareas();
        obtenerSalas();
        fillcombo();
    }

    public Planificar(String fecha, String name) {
        try {
            decorarJTree();
            jtPlanning.resetKeyboardActions();
            DateFormat df1 = new SimpleDateFormat("yyyy/MM/dd");
            Date f;
            f = df1.parse(fecha);
            dcFecha.setDate(f);
            cbEmpleados.setSelectedItem(name);
        } catch (ParseException ex) {
            Logger.getLogger(Planificar.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void decorarJTree() {
        jtPlanning.getSelectionModel().setSelectionMode(TreeSelectionModel.DISCONTIGUOUS_TREE_SELECTION);
        DefaultTreeCellRenderer renderer = (DefaultTreeCellRenderer) jtPlanning.getCellRenderer();

        DefaultTreeModel model = (DefaultTreeModel) jtPlanning.getModel();
        DefaultMutableTreeNode root = (DefaultMutableTreeNode) model.getRoot();
        //Consulta aquí
        //root.add(new DefaultMutableTreeNode("another_child"));
        //
        model.reload(root);

        ImageIcon closedIcon = new ImageIcon("icon.png");
        ImageIcon openIcon = new ImageIcon("icon.png");
        ImageIcon leafIcon = new ImageIcon(Planificar.class.getResource("key.png"));
        renderer.setClosedIcon(closedIcon);
        renderer.setOpenIcon(openIcon);
        renderer.setLeafIcon(leafIcon);

    }

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

    private void fillcombo() {
        try {
            Connection conexion = connection();

            try ( //Creamos la sentencia
                    Statement sentencia = conexion.createStatement()) {
                //Usar la base de datos
                String usarBD = "USE chachachachi;";
                sentencia.executeUpdate(usarBD);
                ResultSet result = sentencia.executeQuery("SELECT nombre FROM empleado");

                while (result.next()) {
                    cbEmpleados.addItem(result.getString(1));
                }
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex);
        }
    }

    public void obtenerTareas() {
        //this.turno = turno;
        try ( //Creamos la conexión
                Connection conexion = connection()) {
            DefaultListModel<String> listaTareas = new DefaultListModel<>();

            //Usar la base de datos
            try ( //Creamos la sentencia
                    Statement sentencia = conexion.createStatement()) {
                //Usar la base de datos
                String usarBD = "USE ChachaChachi;";
                sentencia.executeUpdate(usarBD);
                ResultSet result = sentencia.executeQuery("SELECT P_tarea, texto, duracion FROM tarea;");

                int posicion = 0;
                while (result.next()) {
                    listaTareasModelo.add(posicion, new Tarea(result.getInt(1), result.getString(2), result.getInt(3)));
                    posicion++;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Planificar.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void obtenerSalas() {
        //this.turno = turno;
        try ( //Creamos la conexión
                Connection conexion = connection()) {
            DefaultListModel<String> listaSalas = new DefaultListModel<>();

            //Creamos la sentencia
            Statement sentencia = conexion.createStatement();

            //Usar la base de datos
            String usarBD = "USE ChachaChachi;";
            sentencia.executeUpdate(usarBD);
            ResultSet result = sentencia.executeQuery("SELECT P_sala, nombre FROM sala;");

            int posicion = 0;
            while (result.next()) {
                listaEstanciasModelo.add(posicion, new Sala(result.getInt(1), result.getString(2)));
                posicion++;
            }
            sentencia.close();
        } catch (SQLException ex) {
            Logger.getLogger(Planificar.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void obtenerTareasAsignadas() throws SQLException, SQLException {
        String users = cbEmpleados.getSelectedItem().toString();
        System.out.println("### " + users);
        try ( //Creamos la conexión
                Connection conexion = connection()) {
            DefaultListModel<String> listaTareasAsignadas = new DefaultListModel<>();

            //Creamos la sentencia
            Statement sentencia = conexion.createStatement();

            //Usar la base de datos
            String usarBD = "USE ChachaChachi;";
            sentencia.executeUpdate(usarBD);
            ResultSet result = sentencia.executeQuery("SELECT t.texto FROM  \n"
                    + "tarea t, empleado e, empleado_sala_tarea est\n"
                    + "where e.P_empleado = est.A_empleado AND est.A_tarea = t.P_tarea\n"
                    + "AND e.nombre = \"" + users + "\";");

            while (result.next()) {
                listaTareasAsignadas.addElement(result.getString(1));
            }
            sentencia.close();
        }

    }

    protected void deleteSelectedItems() {
        DefaultMutableTreeNode node;
        DefaultTreeModel model = (DefaultTreeModel) (jtPlanning.getModel());
        TreePath[] paths = jtPlanning.getSelectionPaths();
        for (int i = 0; i < paths.length; i++) {
            node = (DefaultMutableTreeNode) (paths[i].getLastPathComponent());
            model.removeNodeFromParent(node);
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

        jScrollPane4 = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        pArriba = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        cbEmpleados = new javax.swing.JComboBox<>();
        jLabel2 = new javax.swing.JLabel();
        dcFecha = new com.toedter.calendar.JDateChooser();
        pMedio = new javax.swing.JPanel();
        pTareas = new javax.swing.JPanel();
        lblTareas = new javax.swing.JLabel();
        jScrollPane2 = new javax.swing.JScrollPane();
        listaTareas = new javax.swing.JList<>();
        lblEstancias = new javax.swing.JLabel();
        jScrollPane3 = new javax.swing.JScrollPane();
        listaEstancias = new javax.swing.JList<>();
        pBotones = new javax.swing.JPanel();
        btnAddJtree = new javax.swing.JLabel();
        btnRemoveJtree = new javax.swing.JLabel();
        pPlanning = new javax.swing.JPanel();
        lblPlanning = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jtPlanning = new javax.swing.JTree();
        lblTiempoEstimado = new javax.swing.JLabel();
        txtTiempoEstimado = new javax.swing.JLabel();
        btnSave = new javax.swing.JButton();

        jTextArea1.setColumns(20);
        jTextArea1.setRows(5);
        jScrollPane4.setViewportView(jTextArea1);

        setBackground(new java.awt.Color(255, 255, 255));

        pArriba.setBackground(new java.awt.Color(255, 255, 255));
        pArriba.setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jLabel1.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel1.setText("Selecciona empleado:");
        pArriba.add(jLabel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(30, 30, 159, -1));

        cbEmpleados.setFont(new java.awt.Font("Calibri Light", 0, 14)); // NOI18N
        cbEmpleados.setName(""); // NOI18N
        pArriba.add(cbEmpleados, new org.netbeans.lib.awtextra.AbsoluteConstraints(200, 30, 160, -1));

        jLabel2.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        jLabel2.setText("Selecciona una fecha:");
        pArriba.add(jLabel2, new org.netbeans.lib.awtextra.AbsoluteConstraints(470, 30, 158, -1));

        dcFecha.setDateFormatString("yyyy-MM-dd");
        pArriba.add(dcFecha, new org.netbeans.lib.awtextra.AbsoluteConstraints(650, 30, 157, -1));

        pMedio.setBackground(new java.awt.Color(255, 255, 255));

        pTareas.setBackground(new java.awt.Color(255, 255, 255));

        lblTareas.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        lblTareas.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTareas.setText("TAREAS");

        jScrollPane2.setFont(new java.awt.Font("Calibri Light", 0, 14)); // NOI18N

        listaTareas.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        listaTareas.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                listaTareasMouseClicked(evt);
            }
        });
        jScrollPane2.setViewportView(listaTareas);

        lblEstancias.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        lblEstancias.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblEstancias.setText("ESTANCIAS");

        jScrollPane3.setFont(new java.awt.Font("Calibri Light", 0, 14)); // NOI18N

        listaEstancias.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        listaEstancias.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                listaEstanciasMouseClicked(evt);
            }
        });
        jScrollPane3.setViewportView(listaEstancias);

        javax.swing.GroupLayout pTareasLayout = new javax.swing.GroupLayout(pTareas);
        pTareas.setLayout(pTareasLayout);
        pTareasLayout.setHorizontalGroup(
            pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pTareasLayout.createSequentialGroup()
                .addGroup(pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblTareas, javax.swing.GroupLayout.PREFERRED_SIZE, 241, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jScrollPane2))
                .addGap(18, 18, 18)
                .addGroup(pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane3)
                    .addComponent(lblEstancias, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(11, 11, 11))
        );
        pTareasLayout.setVerticalGroup(
            pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pTareasLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblEstancias)
                    .addComponent(lblTareas))
                .addGroup(pTareasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane3)
                    .addComponent(jScrollPane2))
                .addContainerGap())
        );

        pBotones.setBackground(new java.awt.Color(255, 255, 255));

        btnAddJtree.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/next.png"))); // NOI18N
        btnAddJtree.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnAddJtreeMouseClicked(evt);
            }
        });

        btnRemoveJtree.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/remove.png"))); // NOI18N
        btnRemoveJtree.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnRemoveJtreeMouseClicked(evt);
            }
        });

        javax.swing.GroupLayout pBotonesLayout = new javax.swing.GroupLayout(pBotones);
        pBotones.setLayout(pBotonesLayout);
        pBotonesLayout.setHorizontalGroup(
            pBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pBotonesLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnRemoveJtree)
                    .addComponent(btnAddJtree, javax.swing.GroupLayout.Alignment.TRAILING))
                .addContainerGap())
        );
        pBotonesLayout.setVerticalGroup(
            pBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pBotonesLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(btnAddJtree)
                .addGap(63, 63, 63)
                .addComponent(btnRemoveJtree)
                .addContainerGap())
        );

        pPlanning.setBackground(new java.awt.Color(255, 255, 255));

        lblPlanning.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        lblPlanning.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblPlanning.setText("PLANNING");

        jtPlanning.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        javax.swing.tree.DefaultMutableTreeNode treeNode1 = new javax.swing.tree.DefaultMutableTreeNode("Mi hogar");
        javax.swing.tree.DefaultMutableTreeNode treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Cocina");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Sala");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Baño");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Habitación 1");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Habitación 2");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Alacena");
        treeNode1.add(treeNode2);
        treeNode2 = new javax.swing.tree.DefaultMutableTreeNode("Cuarto de estudio");
        treeNode1.add(treeNode2);
        jtPlanning.setModel(new javax.swing.tree.DefaultTreeModel(treeNode1));
        jtPlanning.setMaximumSize(new java.awt.Dimension(233, 233));
        jtPlanning.setPreferredSize(new java.awt.Dimension(233, 233));
        jScrollPane1.setViewportView(jtPlanning);

        lblTiempoEstimado.setFont(new java.awt.Font("Calibri Light", 1, 14)); // NOI18N
        lblTiempoEstimado.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        lblTiempoEstimado.setText("Tiempo estimado:");

        txtTiempoEstimado.setFont(new java.awt.Font("Calibri Light", 0, 13)); // NOI18N
        txtTiempoEstimado.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        txtTiempoEstimado.setText("txtTiempoEstimado");

        btnSave.setFont(new java.awt.Font("Calibri Light", 0, 18)); // NOI18N
        btnSave.setText("GUARDAR PLANNING");
        btnSave.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSaveActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout pPlanningLayout = new javax.swing.GroupLayout(pPlanning);
        pPlanning.setLayout(pPlanningLayout);
        pPlanningLayout.setHorizontalGroup(
            pPlanningLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pPlanningLayout.createSequentialGroup()
                .addGap(27, 27, 27)
                .addGroup(pPlanningLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(pPlanningLayout.createSequentialGroup()
                        .addComponent(lblTiempoEstimado)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtTiempoEstimado))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(lblPlanning, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnSave, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        pPlanningLayout.setVerticalGroup(
            pPlanningLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pPlanningLayout.createSequentialGroup()
                .addComponent(lblPlanning, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                .addGap(10, 10, 10)
                .addGroup(pPlanningLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtTiempoEstimado)
                    .addComponent(lblTiempoEstimado, javax.swing.GroupLayout.PREFERRED_SIZE, 28, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(25, 25, 25)
                .addComponent(btnSave)
                .addContainerGap())
        );

        javax.swing.GroupLayout pMedioLayout = new javax.swing.GroupLayout(pMedio);
        pMedio.setLayout(pMedioLayout);
        pMedioLayout.setHorizontalGroup(
            pMedioLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pMedioLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(pTareas, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(pBotones, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(pPlanning, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(24, 24, 24))
        );
        pMedioLayout.setVerticalGroup(
            pMedioLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pMedioLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pMedioLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(pMedioLayout.createSequentialGroup()
                        .addGap(147, 147, 147)
                        .addComponent(pBotones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(118, 118, 118))
                    .addComponent(pTareas, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(pPlanning, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(0, 68, Short.MAX_VALUE)
                        .addComponent(pArriba, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(0, 69, Short.MAX_VALUE))
                    .addComponent(pMedio, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(20, 20, 20))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(pArriba, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(pMedio, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(128, 128, 128))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void listaTareasMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_listaTareasMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_listaTareasMouseClicked

    private void listaEstanciasMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_listaEstanciasMouseClicked
        // TODO add your handling code here:
    }//GEN-LAST:event_listaEstanciasMouseClicked

    private void btnSaveActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSaveActionPerformed

        System.out.println("Guardar");
        TreeNode root = (TreeNode) jtPlanning.getModel().getRoot();
        for (int i = 0; i < root.getChildCount(); i++) {
            TreeNode salaNode = root.getChildAt(i);
            Sala sala = null;
            for (int j = 0; j < listaEstanciasModelo.getSize(); j++) {
                Sala salaI = (Sala) listaEstanciasModelo.get(j);
                if (salaI.getNombre().equals(salaNode.toString())) {
                    sala = salaI;
                    break;
                }
            }
            if (sala != null) {
                Tarea tarea = null;
                for (int j = 0; j < salaNode.getChildCount(); j++) {
                    TreeNode tareaNode = salaNode.getChildAt(j);
                    for (int k = 0; k < listaTareasModelo.getSize(); k++) {
                        Tarea tareaI = (Tarea) listaTareasModelo.get(k);
                        if (tareaI.getTexto().equals(tareaNode.toString())) {
                            tarea = tareaI;
                            break;
                        }
                    }
                }
                if (tarea != null) {
                    // TODO llevar a BD
                    System.out.println("Guardar" + tarea.getTexto() + " en sala " + sala.getNombre());
                }
            }
        }

        //Una vez ya guardado
        guardado = true;
    }//GEN-LAST:event_btnSaveActionPerformed

    private void btnAddJtreeMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnAddJtreeMouseClicked
        // TODO add your handling code here:
        int[] tareasSeleccionadas = listaTareas.getSelectedIndices();
        int[] estanciasSeleccionadas = listaEstancias.getSelectedIndices();

        DefaultMutableTreeNode root = (DefaultMutableTreeNode) jtPlanning.getModel().getRoot();

        for (int i = 0; i < estanciasSeleccionadas.length; i++) {

            Sala estanciaSelect = (Sala) listaEstanciasModelo.getElementAt(estanciasSeleccionadas[i]);

            for (int j = 0; j < root.getChildCount(); j++) {

                DefaultMutableTreeNode estanciaNode = (DefaultMutableTreeNode) root.getChildAt(j);

                if (estanciaNode.toString().equals(estanciaSelect.getNombre())) {

                    System.out.println("Seleccionada " + estanciaSelect);

                    for (int h = 0; h < tareasSeleccionadas.length; h++) {

                        Tarea tareaSelect = (Tarea) listaTareasModelo.getElementAt(tareasSeleccionadas[h]);

                        System.out.println("Añadiendo tarea " + tareaSelect.getTexto() + " a " + estanciaSelect);

                        estanciaNode.add(new DefaultMutableTreeNode(tareaSelect.getTexto()));
                    }
                }
            }
        }

        for (int k = 0; k < jtPlanning.getRowCount(); k++) {
            jtPlanning.expandRow(k);
        }
        jtPlanning.repaint();
    }//GEN-LAST:event_btnAddJtreeMouseClicked

    private void btnRemoveJtreeMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnRemoveJtreeMouseClicked
        // TODO add your handling code here:
        deleteSelectedItems();
    }//GEN-LAST:event_btnRemoveJtreeMouseClicked


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel btnAddJtree;
    private javax.swing.JLabel btnRemoveJtree;
    private javax.swing.JButton btnSave;
    private javax.swing.JComboBox<String> cbEmpleados;
    private com.toedter.calendar.JDateChooser dcFecha;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JScrollPane jScrollPane4;
    private javax.swing.JTextArea jTextArea1;
    private javax.swing.JTree jtPlanning;
    private javax.swing.JLabel lblEstancias;
    private javax.swing.JLabel lblPlanning;
    private javax.swing.JLabel lblTareas;
    private javax.swing.JLabel lblTiempoEstimado;
    private javax.swing.JList<String> listaEstancias;
    private javax.swing.JList<String> listaTareas;
    private javax.swing.JPanel pArriba;
    private javax.swing.JPanel pBotones;
    private javax.swing.JPanel pMedio;
    private javax.swing.JPanel pPlanning;
    private javax.swing.JPanel pTareas;
    private javax.swing.JLabel txtTiempoEstimado;
    // End of variables declaration//GEN-END:variables
}
