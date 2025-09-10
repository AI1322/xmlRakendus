<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sugupuu.aspx.cs"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <h3>Oma sugupuu</h3>
        <div>
            <asp:Xml runat="server"
                DocumentSource="~/OmaSugupuu.xml"
                TransformSource="~/OmaSugupuu.xslt"
            ></asp:Xml>
        </div>
    </main>

</asp:Content>

