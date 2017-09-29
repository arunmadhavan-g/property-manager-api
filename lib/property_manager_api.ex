defmodule PropertyManagerApi do
  @moduledoc """
  PropertyManagerApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  defmodule ProjectController do
    use PropertyManagerApiWeb, :controller

    def projects(conn, _params), do: json conn, Project.projects()

    def exists(conn, %{"name" => name}), do: json conn, Project.exists?(name)

    def create(conn, %{"name" => name}) do
      Project.create(name)
      json conn, "Created"
    end

    def delete(conn, %{"name" => name}) do
      Project.delete(name)
      json conn, "Deleted"
    end



  end
end
