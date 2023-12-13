import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import compilerTools.Functions;
import compilerTools.Token;

public class TablaLexica extends JFrame{
    private JScrollPane ScrollPane;
    private JTable tabla;
    private ArrayList<Token> tokens;

    public TablaLexica(ArrayList<Token> tokens){
        this.tokens = tokens;
        iniciarComponentes();
    }

    public void iniciarComponentes(){
        this.setSize(400,500);
        this.setDefaultCloseOperation(HIDE_ON_CLOSE);
        this.setLocationRelativeTo(null);
        this.setTitle("Analisis Lexico");
        this.setResizable(false);
        tabla = new JTable();
        ScrollPane = new JScrollPane();
        
        tabla.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Componente léxico", "Lexema", "[Línea, Columna]"
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


        tokens.forEach(token -> {
            Object[] data = new Object[]{token.getLexicalComp(), token.getLexeme(), "[" + token.getLine() + ", " + token.getColumn() + "]"};
            Functions.addRowDataInTable(tabla, data);
        });

        this.add(ScrollPane);

    }
    
}
