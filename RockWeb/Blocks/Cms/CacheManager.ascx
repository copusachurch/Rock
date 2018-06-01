﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CacheManager.ascx.cs" Inherits="RockWeb.Blocks.Cms.CacheManager" %>

<script type="text/javascript">
    function clearActiveDialog() {
        $('#<%=hfActiveDialog.ClientID %>').val('');
    }
</script>

<asp:HiddenField ID="hfActiveDialog" runat="server" />

<asp:UpdatePanel ID="upnlContent" runat="server">
    <ContentTemplate>

        <div class="panel panel-block">
            <div class="panel-heading">
                <h1 class="panel-title"><i class="fa fa-tachometer"></i>Cache Manager</h1>

                <asp:LinkButton ID="btnClearCache" runat="server" CssClass="btn btn-primary btn-xs pull-right" OnClick="btnClearCache_Click" CausesValidation="false">
                    <i class="fa fa-repeat"></i> Clear Cache
                </asp:LinkButton>
            </div>
            <div class="panel-body">
                <Rock:NotificationBox ID="nbMessage" runat="server" Visible="false" Dismissable="true" />

                <div class="row">
                    <div class="col-md-6">
                        <h4>Cache Tags</h4>
                        <Rock:Grid ID="gCacheTagList" runat="server" AllowSorting="true" EmptyDataText="No Tags Found" DisplayType="Light">
                        <Columns>
                            <Rock:RockBoundField DataField="TagName" HeaderText="Tag Name" SortExpression="TagName" />
                            <Rock:RockBoundField DataField="TagDescription" HeaderText="Description" SortExpression="TagDescription" TruncateLength="255" HtmlEncode="false" />
                            <Rock:RockBoundField DataField="LinkedKeys" HeaderText="Linked Keys" SortExpression="LinkedKeys" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                            <Rock:LinkButtonField Text="<i class='fa fa-eraser'></i>" CssClass="btn btn-default btn-sm btn-square" OnClick="gCacheTagList_ClearCacheTag" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                    </Rock:Grid>
                    </div>
                    <div class="col-md-6">
                        <h4>Cache Statistics</h4>
                        <Rock:RockDropDownList ID="ddlCacheTypes" runat="server" DataTextField="Name" DataValueField="Id" Label="Cache Types" OnSelectedIndexChanged="ddlCacheTypes_SelectedIndexChanged" AutoPostBack="true" />
                        <table class="grid-table table table-condensed table-light">
                            <thead><tr><td colspan="2"></td></tr><tr><th>Stat</th><th>Count</th></tr></thead>
                            <asp:Literal ID="lCacheStatistics" runat="server" /><tr><td colspan="2"></td></tr>
                        </table>

                        <br />
                        <Rock:PanelWidget ID="wpGroupSync" runat="server" Title="Redis Backplane Settings" Expanded="false" Visible="false">
                            <div id="redisView" runat="server">
                                <div class="row"><div class="col-md-12"><asp:CheckBox ID="cbEnabled" runat="server" Text="Enable" Enabled="false" /></div></div>
                                <div class="row"><div class="col-md-12">End Points<asp:Literal ID="lEndPointList" runat="server"></asp:Literal></div></div>
                                <div class="row"><div class="col-md-12">Password<asp:Label ID="lblPassword" runat="server"></asp:Label></div></div>
                                <div class="row"><div class="col-md-12">Database Number<asp:Label ID="lblDatabaseNumber" runat="server"></asp:Label></div></div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="actions">
                                            <asp:LinkButton ID="btnEditRedis" runat="server" AccessKey="m" ToolTip="Alt+m" Text="Edit Settings" CssClass="btn btn-primary" OnClick="btnEditRedis_Click" CausesValidation="false" />
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div id="redisEdit" runat="server">
                                <div class="row"><div class="col-md-12"><asp:CheckBox ID="cbEnabledEdit" runat="server" Text="Enable" /></div></div>
                                <div class="row"><div class="col-md-12">End Points<Rock:ListItems ID="liEndPoints" runat="server" Help="List of Redis endpoints (e.g. server.com:6379) to connect to."></Rock:ListItems></div></div>
                                <div class="row"><div class="col-md-12">Password<Rock:RockTextBox ID="tbPassword" runat="server" TextMode="Password" Help="The password used to connect. The need for a password is dependent on your Redis server configuration." ></Rock:RockTextBox></div></div>
                                <div class="row"><div class="col-md-12">Database Number<Rock:RockTextBox ID="tbDatabaseNumber" runat="server" TextMode="Number" Help="The database index number (the default is 0)"></Rock:RockTextBox></div></div>
                                
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="actions">
                                            <asp:LinkButton ID="btnSaveRedis" runat="server" AccessKey="s" ToolTip="Alt+s" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveRedis_Click" />
                                            <asp:LinkButton ID="btnCancelRedis" runat="server" AccessKey="c" ToolTip="Alt+c" Text="Cancel" CssClass="btn btn-link" CausesValidation="false" OnClick="btnCancelRedis_Click" />
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </Rock:PanelWidget>
                    </div>
                </div>

            </div>
        </div>

        <Rock:ModalDialog ID="dlgAddTag" runat="server" Title="Add Tag" OnSaveClick="dlgAddTag_SaveClick" OnCancelScript="clearActiveDialog();" >
            <Content>
                <Rock:NotificationBox ID="nbModalMessage" runat="server" Visible="false" />
                <div class="row">
                    <div class="col-md-6">
                        <Rock:RockTextBox ID="tbTagName" runat="server" Label="Tag Name" onkeypress="this.value = this.value.toLowerCase().replace(' ', '-');" Style="text-transform: lowercase;" Width="100%"/>
                    </div>
                    <div class="col-md-6">
                        <Rock:RockTextBox ID="tbTagDescription" runat="server" Label="Description" TextMode="MultiLine" Rows="3" Width="100%"/>
                    </div>
                </div>
            </Content>
        </Rock:ModalDialog>

    </ContentTemplate>
</asp:UpdatePanel>