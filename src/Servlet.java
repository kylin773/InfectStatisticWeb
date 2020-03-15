

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javafx.beans.property.SetProperty;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stubr
		String province = (String)request.getParameter("province");
		
		if (province != null) {
			request.setAttribute("province", province);
			request.setAttribute("provinceData", InfectStatisticWeb.dealDetail(province));
			request.getRequestDispatcher("detail.jsp").forward(request, response);
		}
		else {
			request.setAttribute("data", InfectStatisticWeb.dealData());
			request.setAttribute("overall", InfectStatisticWeb.dealOverall());
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.setCharacterEncoding("utf-8");
		//response.getWriter().println(InfectStatisticWeb.dealData());
		doGet(request, response);
	}

}
