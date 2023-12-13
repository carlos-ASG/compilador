import java.util.ArrayList;
import java.util.HashMap;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import compilerTools.Functions;
import compilerTools.Token;

public class TablaSimbolos extends JFrame{
    private JScrollPane ScrollPane;
    private JTable tabla;
    private ArrayList<HashMap<String,String>> simbolos;

    public TablaSimbolos(ArrayList<HashMap<String,String>> simbolos){
        this.simbolos = simbolos;
        iniciarComponentes();
    }

    public void iniciarComponentes(){
        this.setSize(400,500);
        this.setDefaultCloseOperation(HIDE_ON_CLOSE);
        this.setLocationRelativeTo(null);
        this.setTitle("Tabla de Simbolos");
        this.setResizable(false);
        tabla = new JTable();
        ScrollPane = new JScrollPane();
        
        tabla.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Nombre", "Tipo de dato", "valor"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tabla.getTableHeader().setReorderingAllowed(false);
        ScrollPane.setViewportView(tabla);


        simbolos.forEach(simbolo -> {
            Object[] data = new Object[]{simbolo.get("nombre"),simbolo.get("tipo") , simbolo.get("valor")};
            Functions.addRowDataInTable(tabla, data);
        });

        this.add(ScrollPane);

    }
    
}
