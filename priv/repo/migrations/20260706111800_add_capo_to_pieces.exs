defmodule Tabby.Repo.Migrations.AddCapoToPieces do
  use Ecto.Migration

  def change do
    alter table("pieces") do
      add :capo, :string
    end
  end
end
